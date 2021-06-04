# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{7,8,9} )
PYTHON_REQ_USE="xml"

inherit meson gnome2-utils multilib pax-utils python-single-r1 xdg

DESCRIPTION="A fork of GNOME Shell with layout similar to GNOME 2"
HOMEPAGE="https://projects.linuxmint.com/cinnamon/"
SRC_URI="https://github.com/linuxmint/cinnamon/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
IUSE="gtk-doc +nls +networkmanager"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
KEYWORDS="~amd64 ~x86"

COMMON_DEPEND="${PYTHON_DEPS}
	app-accessibility/at-spi2-atk:2
	app-misc/ca-certificates
	>=dev-libs/glib-2.52.0:2[dbus]
	>=dev-libs/gobject-introspection-1.29.15:=
	dev-libs/libxml2:2
	>=gnome-extra/cinnamon-desktop-5.0:0=
	>=gnome-extra/cinnamon-menus-5.0
	>=gnome-extra/cjs-5.0[cairo]
	>=gnome-base/gsettings-desktop-schemas-2.91.91
	media-libs/gstreamer:1.0
	media-libs/gst-plugins-base:1.0
	net-libs/libsoup:2.4[introspection]
	>=sys-auth/polkit-0.100[introspection]
	x11-libs/gdk-pixbuf:2[introspection]
	>=x11-libs/gtk+-3.12.0:3[introspection]
	x11-libs/pango[introspection]
	>=x11-libs/startup-notification-0.11
	x11-libs/libX11
	>=x11-libs/libXfixes-5.0
	>=x11-wm/muffin-5.0[introspection]
	dev-libs/keybinder:3[introspection]
	>=x11-libs/libnotify-0.7.3:0=[introspection]
"
# Runtime-only deps are probably incomplete and approximate.
# Each block:
# 2. Introspection stuff + dconf needed via imports.gi.*
# 3. gnome-session is needed for gnome-session-quit
# 4. Control shell settings
# 5. accountsservice is needed for GdmUserManager (0.6.14 needed for fast
#    user switching with gdm-3.1.x)
# 6. caribou needed for on-screen keyboard
# 7. xdg-utils needed for xdg-open, used by extension tool
# 8. imaging, lxml needed for cinnamon-settings
# 9. adwaita-icon-theme needed for various icons
# 10. pygobject needed for menu editor
# 11. nemo - default file manager, tightly integrated with cinnamon
# 12. polkit-gnome - explicitly autostarted by us
# TODO(lxnay): fix error: libgnome-desktop/gnome-rr-labeler.h: No such file or directory
RDEPEND="${COMMON_DEPEND}
	>=gnome-base/dconf-0.4.1
	>=gnome-base/libgnomekbd-2.91.4
	sys-power/upower[introspection]

	>=gnome-extra/cinnamon-session-5.0
	>=gnome-extra/cinnamon-settings-daemon-5.0

	>=app-accessibility/caribou-0.3

	dev-libs/libtimezonemap
	x11-misc/xdg-utils
	>=x11-libs/xapps-1.9.0[introspection]

	$(python_gen_cond_dep '
		dev-python/dbus-python[${PYTHON_USEDEP}]
		dev-python/distro[${PYTHON_USEDEP}]
		dev-python/pygobject:3[${PYTHON_USEDEP}]
		dev-python/pexpect[${PYTHON_USEDEP}]
		dev-python/pycairo[${PYTHON_USEDEP}]
		dev-python/pyinotify[${PYTHON_USEDEP}]
		dev-python/python-pam[${PYTHON_USEDEP}]
		dev-python/pillow[${PYTHON_USEDEP}]
		dev-python/setproctitle[${PYTHON_USEDEP}]
		dev-python/tinycss2[${PYTHON_USEDEP}]
		dev-python/pytz[${PYTHON_USEDEP}]
		dev-python/xapp[${PYTHON_USEDEP}]
	')

	x11-themes/gnome-themes-standard
	x11-themes/adwaita-icon-theme

	>=gnome-extra/nemo-5.0
	>=gnome-extra/cinnamon-control-center-5.0[networkmanager=]
	>=gnome-extra/cinnamon-screensaver-5.0

	gnome-extra/polkit-gnome

	nls? ( >=gnome-extra/cinnamon-translations-5.0 )
"
DEPEND="${COMMON_DEPEND}
	>=dev-util/intltool-0.40
	>=sys-devel/gettext-0.17
	virtual/pkgconfig
	gtk-doc? ( dev-util/gtk-doc )
"

PATCHES=(
	# Fix backgrounds path as cinnamon doesn't provide them
	# https://github.com/linuxmint/Cinnamon/issues/3575
	"${FILESDIR}"/${PN}-3.8.0-gnome-background-compatibility.patch

	# Use wheel group instead of sudo (from Fedora/Arch)
	# https://github.com/linuxmint/Cinnamon/issues/3576
	"${FILESDIR}"/${PN}-3.6.6-wheel-sudo.patch
)

src_prepare() {
	xdg_src_prepare
	gnome2_disable_deprecation_warning

	# Add polkit agent to required components (from Fedora/Arch), bug #523958
	# https://github.com/linuxmint/Cinnamon/issues/3579
	sed -i 's/RequiredComponents=\(.*\)$/RequiredComponents=\1polkit-gnome-authentication-agent-1;/' \
		cinnamon*.session.in || die

	# shebang fixing craziness
	local p
	for p in $(grep -rl '#!.*python3'); do
		python_fix_shebang "${p}"
	done
}

src_configure() {
	local emesonargs=(
		-Dbuild_recorder=true
		-Ddeprecated_warnings=false
		$(meson_use gtk-doc docs)
		$(meson_use !networkmanager disable_networkmanager)
	)
	meson_src_configure
}

src_compile() {
	# parallel build fails imtermittently
	meson_src_compile -j1
}

src_install() {
	meson_src_install
	python_optimize "${ED}"/usr/share/cinnamon/

	# Required for gnome-shell on hardened/PaX, bug #398941
	pax-mark mr "${ED}"/usr/bin/cinnamon

	# Doesn't exist on Gentoo, causing this to be a dead symlink
	rm -f "${ED}/etc/xdg/menus/cinnamon-applications-merged" || die

	# Ensure authentication-agent is started, bug #523958
	# https://github.com/linuxmint/Cinnamon/issues/3579
	insinto /etc/xdg/autostart/
	doins "${FILESDIR}"/polkit-cinnamon-authentication-agent-1.desktop
}

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_schemas_update

	if ! has_version 'media-libs/gst-plugins-good:1.0' || \
	   ! has_version 'media-plugins/gst-plugins-vpx:1.0'; then
		ewarn "To make use of Cinnamon's built-in screen recording utility,"
		ewarn "you need to either install media-libs/gst-plugins-good:1.0"
		ewarn "and media-plugins/gst-plugins-vpx:1.0, or use dconf-editor to change"
		ewarn "org.cinnamon.recorder/pipeline to what you want to use."
	fi
}

pkg_postrm() {
	xdg_pkg_postinst
	gnome2_schemas_update
}
