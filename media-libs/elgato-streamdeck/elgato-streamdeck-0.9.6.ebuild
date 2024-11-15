# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1

DESCRIPTION="Python library to control the Elgato Stream Deck"
HOMEPAGE="https://github.com/abcminiuser/python-elgato-streamdeck"
SRC_URI="https://github.com/abcminiuser/python-elgato-streamdeck/archive/${PV}.tar.gz -> ${P}.gh.tar.gz"

S="${WORKDIR}/python-${P}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-python/pillow[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}
	dev-libs/hidapi
"

python_test() {
	"${EPYTHON}" test/test.py || die "Tests fail with ${EPYTHON}"
}
