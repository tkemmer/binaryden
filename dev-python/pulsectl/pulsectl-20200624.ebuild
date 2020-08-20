# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8} )

inherit distutils-r1

MY_PN="python-pulse-control"
COMMIT="471428cd7d03356f0641fe93a8156b799d57ce02"
S="${WORKDIR}/${MY_PN}-${COMMIT}"

DESCRIPTION="Python high-level interface and ctypes-based bindings for PulseAudio"
HOMEPAGE="https://github.com/mk-fg/python-pulse-control"
SRC_URI="https://github.com/mk-fg/${MY_PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

python_test() {
	"${EPYTHON}" -m unittest -v pulsectl.tests.all
}
