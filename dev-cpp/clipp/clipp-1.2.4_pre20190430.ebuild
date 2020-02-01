# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
COMMIT=2c32b2f1f7cc530b1ec1f62c92f698643bb368db

inherit cmake

DESCRIPTION="Easy to use, powerful & expressive command line argument parsing for modern C++"
HOMEPAGE="https://github.com/muellan/clipp"
SRC_URI="https://github.com/muellan/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

DEPEND=""
RDEPEND=""

S="${WORKDIR}"/${PN}-${COMMIT}

src_configure() {
	local mycmakeargs=(
		-DBUILD_TESTING="$(usex test)"
	)
	cmake_src_configure
}
