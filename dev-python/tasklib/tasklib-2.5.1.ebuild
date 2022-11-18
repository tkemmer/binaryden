# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..11} )

inherit distutils-r1

DESCRIPTION="A Python library for interacting with taskwarrior databases"
HOMEPAGE="https://github.com/GothenburgBitFactory/tasklib"
SRC_URI="
	https://github.com/GothenburgBitFactory/${PN}/archive/${PV}.tar.gz
		-> ${P}.gh.tar.gz
"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	app-misc/task
"

distutils_enable_sphinx docs --no-autodoc
distutils_enable_tests setup.py
