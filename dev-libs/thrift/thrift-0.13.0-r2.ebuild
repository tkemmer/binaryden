# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="Software framework for scalable cross-language services development"
HOMEPAGE="https://thrift.apache.org/"
SRC_URI="https://github.com/apache/thrift/archive/${PV}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0/${PV}"
KEYWORDS="~amd64"

IUSE="examples +libevent +openssl qt5 static-libs test +zlib"
REQUIRED_USE=""

COMMON_DEPEND="
	dev-libs/glib:2
	libevent? ( dev-libs/libevent:= )
	openssl? ( dev-libs/openssl:= )
	qt5? (
		dev-qt/qtcore:5=
		dev-qt/qtnetwork:5=
	)
	zlib? ( sys-libs/zlib:= )
"
RDEPEND="${COMMON_DEPEND}"
DEPEND="${COMMON_DEPEND}"

src_configure() {
	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=$(usex !static-libs)
		-DBUILD_TESTING=$(usex test)
		-DBUILD_TUTORIALS=$(usex examples)
		-DCMAKE_C_FLAGS="-fPIC"
		-DCMAKE_CXX_FLAGS="-fPIC"
		-DWITH_HASKELL=OFF
		-DWITH_JAVA=OFF
		-DWITH_OPENSSL=$(usex openssl)
		-DWITH_PYTHON=OFF
		-DWITH_QT5=$(usex qt5)
		-DWITH_ZLIB=$(usex zlib)
	)
	cmake_src_configure
}
