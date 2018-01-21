# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils

DESCRIPTION="Cross-language development platform for in-memory data"
HOMEPAGE="https://parquet.apache.org/"
SRC_URI="https://github.com/apache/parquet-cpp/archive/apache-${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

IUSE="cpu_flags_x86_sse4_2 static-libs test"
REQUIRED_USE="test? ( static-libs )"

S="${WORKDIR}/${PN}-apache-${P}"
CMAKE_BUILD_TYPE="release"

COMMON_DEPEND="
	<dev-libs/arrow-cpp-0.8
	dev-libs/boost
	<dev-libs/thrift-0.11[static-libs]
"
RDEPEND="${COMMON_DEPEND}"
DEPEND="${COMMON_DEPEND}"

src_configure() {
	local mycmakeargs=(
		-DPARQUET_BUILD_STATIC=$(usex static-libs)
		-DPARQUET_BUILD_TESTS=$(usex test)
		-DPARQUET_USE_SSE=$(usex cpu_flags_x86_sse4_2)
		-DTHRIFT_HOME="${EPREFIX}/usr"
	)
	cmake-utils_src_configure
}

src_test() {
	export PARQUET_TEST_DATA="${S}/data"
	cmake-utils_src_test
}
