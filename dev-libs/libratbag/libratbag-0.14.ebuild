# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8} )

inherit meson python-r1 systemd udev

DESCRIPTION="Library to configure gaming mice"
HOMEPAGE="https://github.com/libratbag/libratbag"
SRC_URI="https://github.com/${PN}/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0/3"
KEYWORDS="~amd64 ~x86"
IUSE="doc elogind systemd test"

DEPEND="
	dev-lang/swig
	dev-libs/libunistring:=
	virtual/pkgconfig
	doc? ( app-doc/doxygen )
	test? (
		dev-libs/check
		dev-util/valgrind
	)
"
RDEPEND="
	dev-libs/glib:2
	dev-libs/json-glib
	dev-libs/libevdev
	virtual/libudev:=
	elogind? ( sys-auth/elogind )
	!elogind? ( sys-apps/systemd:= )
"

pkg_setup() {
	python_setup
}

src_prepare() {
	default

	sed '/default:/d' -i meson_options.txt || die
}

src_configure() {
	local emesonargs=(
		-Ddocumentation=$(usex doc true false)
		-Dlogind-provider=$(usex elogind elogind systemd)
		-Dsystemd=$(usex systemd true false)
		-Dsystemd-unit-dir=$(systemd_get_systemunitdir)
		-Dtests=$(usex test true false)
		-Dudev-dir=$(get_udevdir)
	)
	meson_src_configure
}
