# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..10} )
DISTUTILS_SINGLE_IMPL=1

inherit distutils-r1

DESCRIPTION="VIT is a lightweight, fast, curses-based front end to Taskwarrior"
HOMEPAGE="https://github.com/vit-project/vit"
SRC_URI="
	https://github.com/vit-project/${PN}/archive/v${PV}.tar.gz
		-> ${P}.gh.tar.gz
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	app-misc/task

	$(python_gen_cond_dep '
		dev-python/urwid[${PYTHON_USEDEP}]
		dev-python/tasklib[${PYTHON_USEDEP}]
		dev-python/tzlocal[${PYTHON_USEDEP}]
	' 'python*' )

	python_single_target_python3_8? (
		dev-python/backports-zoneinfo[python_targets_python3_8]
	)
"

PATCHES=(
	"${FILESDIR}"/${PN}-2.2.0-update-packages.patch
)

DOCS=(
	AUTHORS.md CHANGES.md COLOR.md CUSTOMIZE.md FAQ.md README.md
)

distutils_enable_tests setup.py
