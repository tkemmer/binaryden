# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson xdg-utils

DESCRIPTION="A set of symbolic icons for Gtk applications and projects"
HOMEPAGE="https://github.com/xapp-project/xapp-symbolic-icons"

SRC_URI="https://github.com/xapp-project/xapp-symbolic-icons/archive/${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="LGPL-3"
SLOT="0"

KEYWORDS="~amd64 ~arm64 ~loong ~ppc64 ~riscv ~x86"

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
