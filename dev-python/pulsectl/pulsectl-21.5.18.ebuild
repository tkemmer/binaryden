# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8,9} )

inherit distutils-r1

MY_PN="python-pulse-control"
COMMIT="6661f2c8c58d7145d2e7274a71477bb1f60850c0"
S="${WORKDIR}/${MY_PN}-${COMMIT}"

DESCRIPTION="Python high-level interface and ctypes-based bindings for PulseAudio"
HOMEPAGE="https://github.com/mk-fg/python-pulse-control"
SRC_URI="https://github.com/mk-fg/${MY_PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

python_test() {
	"${EPYTHON}" -m unittest discover
}
