# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson gnome2-utils xdg-utils virtualx

DESCRIPTION="Compositing window manager forked from Mutter for use with Cinnamon"
HOMEPAGE="https://projects.linuxmint.com/cinnamon/ https://github.com/linuxmint/muffin"
SRC_URI="https://github.com/linuxmint/muffin/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
IUSE="input_devices_wacom +introspection sysprof test"
KEYWORDS="~amd64 ~arm64 ~x86"

RDEPEND="
	>=dev-libs/glib-2.37.3:2[dbus]
	>=dev-libs/json-glib-1.0
	>=gnome-extra/cinnamon-desktop-5.2:0=
	gnome-extra/zenity
	>=media-libs/libcanberra-0.26[gtk3]
	media-libs/libglvnd
	>=x11-libs/cairo-1.14:=[X]
	x11-libs/gdk-pixbuf:2[introspection?]
	>=x11-libs/gtk+-3.9.12:3[X,introspection?]
	x11-libs/libICE
	x11-libs/libSM
	x11-libs/libX11
	x11-libs/libxcb
	>=x11-libs/libXcomposite-0.3
	x11-libs/libXcursor
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	>=x11-libs/libXi-1.6.0
	x11-libs/libXinerama
	>=x11-libs/libxkbcommon-0.4.3[X]
	x11-libs/libxkbfile
	x11-libs/libXrandr
	x11-libs/libXrender
	>=x11-libs/pango-1.14.0[X,introspection?]
	>=x11-libs/startup-notification-0.7:=
	x11-misc/xkeyboard-config

	introspection? ( >=dev-libs/gobject-introspection-0.9.12:= )
	input_devices_wacom? ( >=dev-libs/libwacom-0.13:= )
	sysprof? ( dev-util/sysprof-capture:3= )
"
DEPEND="
	${RDEPEND}
	x11-base/xorg-proto

	test? ( app-text/docbook-xml-dtd:4.5 )
"
# needs gtk-doc, not just -am, for gtk-doc.make
BDEPEND="
	dev-util/glib-utils
	dev-util/gtk-doc
	dev-util/gtk-doc-am
	>=dev-util/intltool-0.35
	sys-devel/gettext
	virtual/pkgconfig
"

src_prepare() {
	default
	gnome2_disable_deprecation_warning
}

# Wayland is not supported upstream.
src_configure() {
	local emesonargs=(
		-Dcore_tests=false
		-Dinstalled_tests=false
		-Dremote_desktop=false
		-Dsm=true
		$(meson_use introspection)
		$(meson_use input_devices_wacom libwacom)
		$(meson_use test clutter_tests)
		$(meson_use test cogl_tests)
		$(meson_use test tests)
	)
	meson_src_configure
}

src_install() {
	meson_src_install
	find "${D}" -name '*.la' -delete || die
	dodoc doc/*.txt
}

src_test() {
	virtx meson_src_test
}

pkg_postinst() {
	xdg_desktop_database_update
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_desktop_database_update
	gnome2_schemas_update
}
