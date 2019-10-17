# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{5,6,7} )

inherit meson python-r1

DESCRIPTION="GTK application to configure gaming mice"
HOMEPAGE="https://github.com/libratbag/piper"
SRC_URI="https://github.com/libratbag/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	>=dev-libs/libratbag-0.10:=
	virtual/pkgconfig
"
RDEPEND="
	dev-python/pygobject:3[${PYTHON_USEDEP}]
	dev-python/python-evdev[${PYTHON_USEDEP}]
"

pkg_setup() {
	python_setup
}
