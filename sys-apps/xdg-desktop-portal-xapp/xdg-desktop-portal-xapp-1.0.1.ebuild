# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson systemd

DESCRIPTION="Xapp-based backend implementation for xdg-desktop-portal"
HOMEPAGE="https://github.com/linuxmint/xdg-desktop-portal-xapp"
SRC_URI="https://github.com/linuxmint/xdg-desktop-portal-xapp/archive/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~riscv ~x86"

DEPEND="
	>=dev-libs/glib-2.44:2[dbus]
	>=sys-apps/xdg-desktop-portal-1.5
	>=x11-libs/gtk+-3.24.0:3[introspection]
"
RDEPEND="${DEPEND}"
BDEPEND=""

src_configure() {
	local emesonargs=(
		-Dsystemduserunitdir="$(systemd_get_userunitdir)"
	)
	meson_src_configure
}
