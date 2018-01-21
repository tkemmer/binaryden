# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils

DESCRIPTION="Powering Columnar In-Memory Analytics"
HOMEPAGE="https://arrow.apache.org/"
SRC_URI="https://github.com/apache/arrow/archive/apache-arrow-${PV}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

IUSE="brotli cpu_flags_x86_sse3 cpu_flags_x86_sse4_2 deprecated jemalloc lz4 +snappy static-libs test +zlib zstd"
REQUIRED_USE="test? ( brotli lz4 snappy static-libs zlib zstd )"

S="${WORKDIR}/arrow-apache-arrow-${PV}/cpp"
CMAKE_BUILD_TYPE="release"

COMMON_DEPEND="
	dev-libs/boost
	jemalloc? ( dev-libs/jemalloc )
"
RDEPEND="${COMMON_DEPEND}"
DEPEND="${COMMON_DEPEND}"

src_configure() {
	local mycmakeargs=(
		-DARROW_ALTIVEC=OFF
		-DARROW_BUILD_STATIC=$(usex static-libs)
		-DARROW_BUILD_TESTS=$(usex test)
		-DARROW_NO_DEPRECATED_API=$(usex !deprecated)
		-DARROW_SSE3=$(usex cpu_flags_x86_sse3)
		-DARROW_USE_SSE=$(usex cpu_flags_x86_sse4_2)
		-DARROW_VERBOSE_THIRDPARTY_BUILD=OFF
		-DARROW_WITH_BROTLI=$(usex brotli)
		-DARROW_WITH_LZ4=$(usex lz4)
		-DARROW_WITH_SNAPPY=$(usex snappy)
		-DARROW_WITH_ZLIB=$(usex zlib)
		-DARROW_WITH_ZSTD=$(usex zstd)
	)
	cmake-utils_src_configure
}
