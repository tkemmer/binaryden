# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit meson gnome2-utils xdg

DESCRIPTION="Cinnamons's main interface to configure various aspects of the desktop"
HOMEPAGE="https://projects.linuxmint.com/cinnamon/"
SRC_URI="https://github.com/linuxmint/cinnamon-control-center/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
IUSE="+colord gnome-online-accounts input_devices_wacom +networkmanager +modemmanager systemd"
REQUIRED_USE="modemmanager? ( networkmanager )"
KEYWORDS="~amd64 ~x86"

COMMON_DEPEND="
	>=dev-libs/glib-2.44:2
	dev-libs/libxml2:2
	>=gnome-base/libgnomekbd-3:0=
	>=gnome-extra/cinnamon-desktop-5.0:0=
	>=gnome-extra/cinnamon-menus-5.0:0=
	media-libs/fontconfig
	networkmanager? (
		>=net-misc/networkmanager-1.2.0:=[modemmanager?]
		>=gnome-extra/nm-applet-1.2.0
		modemmanager? ( >=net-misc/modemmanager-0.7 )
	)
	>=sys-auth/polkit-0.103
	>=x11-libs/gdk-pixbuf-2.23.0:2
	>=x11-libs/gtk+-3.16:3
	>=x11-libs/libnotify-0.7.3:0=
	x11-libs/libX11
	>=x11-libs/libxklavier-5.1
	colord? ( >=x11-misc/colord-0.1.14:0= )
	gnome-online-accounts? ( >=net-libs/gnome-online-accounts-3.18.0 )
	input_devices_wacom? (
		>=dev-libs/libwacom-0.7
		>=x11-libs/libXi-1.2 )
"
# libgnomekbd needed only for gkbd-keyboard-display tool
RDEPEND="${COMMON_DEPEND}
	systemd? ( >=sys-apps/systemd-31 )
	!systemd? ( app-admin/openrc-settingsd )
	x11-themes/adwaita-icon-theme
	colord? ( >=gnome-extra/gnome-color-manager-3 )
	input_devices_wacom? ( gnome-extra/cinnamon-settings-daemon[input_devices_wacom] )
"
DEPEND="${COMMON_DEPEND}
	app-text/iso-codes
	x11-base/xorg-proto
"
BDEPEND="
	dev-util/glib-utils
	>=dev-util/intltool-0.40.1
	>=sys-devel/gettext-0.17
	virtual/pkgconfig
"

src_configure() {
	local emesonargs=(
		$(meson_use colord color)
		$(meson_use gnome-online-accounts onlineaccounts)
		$(meson_use input_devices_wacom wacom)
		$(meson_use modemmanager)
		$(meson_use networkmanager)
	)
	meson_src_configure
}

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_pkg_postrm
	gnome2_schemas_update
}

