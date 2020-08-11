# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit xdg-utils

DESCRIPTION="Pretty simple Linux icon theme inspired by material design"
HOMEPAGE="https://github.com/daniruiz/flat-remix"
SRC_URI="https://github.com/daniruiz/flat-remix/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+blue +green +red +yellow"
REQUIRED_USE="|| ( blue green red yellow )"

RDEPEND=""
DEPEND=""

src_install() {
	insinto /usr/share/icons/
	use blue   && doins -r Flat-Remix-Blue*
	use green  && doins -r Flat-Remix-Green*
	use red    && doins -r Flat-Remix-Red*
	use yellow && doins -r Flat-Remix-Yellow*
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
