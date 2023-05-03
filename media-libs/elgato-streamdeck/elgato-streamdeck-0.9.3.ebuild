# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1

DESCRIPTION="Python library to control the Elgato Stream Deck"
HOMEPAGE="https://github.com/abcminiuser/python-elgato-streamdeck"
SRC_URI="https://github.com/abcminiuser/python-elgato-streamdeck/archive/${PV}.tar.gz -> ${P}.gh.tar.gz"
KEYWORDS="~amd64 ~x86"

S="${WORKDIR}/python-${P}"

LICENSE="MIT"
SLOT="0"
IUSE=""

DEPEND="dev-python/pillow[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}
	dev-libs/hidapi
"

python_test() {
	"${EPYTHON}" src/test.py || die "Tests fail with ${EPYTHON}"
}
