# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils

DESCRIPTION="Cross-language development platform for in-memory data (C++ interface)"
HOMEPAGE="https://arrow.apache.org/"
SRC_URI="https://github.com/apache/arrow/archive/apache-arrow-${PV}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

IUSE="brotli ccache deprecated glog lz4 openssl parquet +snappy static-libs +zlib zstd"

S="${WORKDIR}/arrow-apache-arrow-${PV}/cpp"
CMAKE_BUILD_TYPE="release"

COMMON_DEPEND="
	dev-cpp/gflags
	dev-libs/boost
	dev-libs/double-conversion
	dev-libs/rapidjson
	dev-libs/thrift
	ccache? ( dev-util/ccache )
	glog? ( dev-cpp/glog )
	openssl? ( dev-libs/openssl )
"
RDEPEND="${COMMON_DEPEND}"
DEPEND="${COMMON_DEPEND}"

# Testing requires files from https://github.com/apache/parquet-testing
RESTRICT="test"

# - Arrow forces shipped jemalloc => disable
# - ARROW_IPC requires Flatbuffers, which results in build errors due to
#   broken find_program calls for flatc => disable
src_configure() {
	local mycmakeargs=(
		-DARROW_ALTIVEC=OFF
		-DARROW_BUILD_STATIC="$(usex static-libs)"
		-DARROW_IPC=OFF
		-DARROW_JEMALLOC=OFF
		-DARROW_NO_DEPRECATED_API="$(usex !deprecated)"
		-DARROW_PARQUET="$(usex parquet)"
		-DARROW_USE_GLOG="$(usex glog)"
		-DARROW_VERBOSE_THIRDPARTY_BUILD=OFF
		-DARROW_WITH_BROTLI="$(usex brotli)"
		-DARROW_WITH_LZ4="$(usex lz4)"
		-DARROW_WITH_SNAPPY="$(usex snappy)"
		-DARROW_WITH_ZLIB="$(usex zlib)"
		-DARROW_WITH_ZSTD="$(usex zstd)"
	)
	cmake-utils_src_configure
}
