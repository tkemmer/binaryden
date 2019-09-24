# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils

MY_P="${P/_/}"

DESCRIPTION="SVG based generic vector-drawing program"
HOMEPAGE="https://inkscape.org/"
SRC_URI="https://inkscape.org/gallery/item/14917/${PN}-1.0beta1.tar.bz2"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="cdr dbus graphicsmagick imagemagick jemalloc jpeg openmp"
IUSE+=" lcms nls spell static-libs visio wpg"

REQUIRED_USE="graphicsmagick? ( !imagemagick )"

COMMON_DEPEND="
	app-text/poppler:=[cairo]
	dev-cpp/cairomm
	dev-cpp/glibmm
	dev-cpp/gtkmm:3.0
	dev-libs/boehm-gc
	dev-libs/boost:=
	dev-libs/double-conversion:=
	dev-libs/gdl:3=
	dev-libs/glib:2
	dev-libs/libsigc++:2
	dev-libs/libxml2:2
	dev-libs/libxslt
	media-gfx/potrace
	media-libs/fontconfig
	media-libs/harfbuzz:=
	media-libs/libpng:0=
	net-libs/libsoup:2.4
	sci-libs/gsl:=
	virtual/libiconv
	virtual/libintl
	x11-libs/gtk+:3
	x11-libs/libX11
	x11-libs/pango
	cdr? (
		dev-libs/librevenge
		media-libs/libcdr
	)
	dbus? ( dev-libs/dbus-glib )
	graphicsmagick? ( media-gfx/graphicsmagick:=[cxx] )
	imagemagick? ( media-gfx/imagemagick:=[cxx] )
	jemalloc? ( dev-libs/jemalloc:= )
	jpeg? ( virtual/jpeg:0 )
	lcms? ( media-libs/lcms:2 )
	spell? (
		app-text/aspell
		app-text/gtkspell:3
	)
	visio? (
		dev-libs/librevenge
		media-libs/libvisio
	)
	wpg? (
		app-text/libwpg:0.3
		dev-libs/librevenge
	)
"

RDEPEND="${COMMON_DEPEND}"

DEPEND="${COMMON_DEPEND}
	virtual/pkgconfig
"

S="${WORKDIR}/${MY_P}"

RESTRICT="test"

pkg_pretend() {
	if [[ ${MERGE_TYPE} != binary ]] && use openmp; then
		tc-has-openmp || die "Please switch to an openmp compatible compiler"
	fi
}

src_prepare() {
	cmake-utils_src_prepare
}

src_configure() {
	# aliasing unsafe wrt #310393
	append-flags -fno-strict-aliasing

	local mycmakeargs=(
		-DWITH_DBUS="$(usex dbus)"
		-DENABLE_LCMS="$(usex lcms)"
		-DWITH_OPENMP="$(usex openmp)"
		-DBUILD_SHARED_LIBS="$(usex !static-libs)"
		-DWITH_IMAGE_MAGICK="$(usex imagemagick)"
		-DWITH_GRAPHICS_MAGICK="$(usex graphicsmagick)"
		-DWITH_LIBCDR="$(usex cdr)"
		-DWITH_LIBVISIO="$(usex visio)"
		-DWITH_LIBWPG="$(usex wpg)"
		-DWITH_NLS="$(usex nls)"
		-DWITH_JEMALLOC="$(usex jemalloc)"
	)
	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
}

src_install() {
	cmake-utils_src_install

	find "${ED}" -name "*.la" -delete || die
}
