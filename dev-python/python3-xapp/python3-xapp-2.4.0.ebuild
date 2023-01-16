# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DISTUTILS_USE_PEP517=no
PYTHON_COMPAT=( python3_{9..11} )

inherit meson distutils-r1

DESCRIPTION="Python bindings for x11-libs/xapp"
HOMEPAGE="https://github.com/linuxmint/python3-xapp"
SRC_URI="https://github.com/linuxmint/python3-xapp/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~riscv ~x86"
IUSE=""
RESTRICT="test"

DEPEND="
	>=x11-libs/xapp-2.4.0[introspection]
"
RDEPEND="
	${DEPEND}
	dev-python/psutil[${PYTHON_USEDEP}]
"

python_configure() {
	meson_src_configure
}

python_compile() {
	meson_src_configure
}

python_install() {
	meson_src_install
	python_optimize
}
