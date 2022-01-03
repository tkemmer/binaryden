# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools gnome2 vala

DESCRIPTION="A slick-looking LightDM greeter"
HOMEPAGE="https://github.com/linuxmint/slick-greeter"
SRC_URI="https://github.com/linuxmint/${PN}/archive/${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

COMMON_DEPEND="
	dev-libs/glib:2
	media-libs/freetype:=
	media-libs/libcanberra
	x11-libs/cairo
	x11-libs/gtk+:3[X]
	x11-libs/libXext
	x11-libs/pixman
	x11-misc/lightdm[introspection,vala]"

RDEPEND="${COMMON_DEPEND}"

DEPEND="${COMMON_DEPEND}
	$(vala_depend)
	dev-util/intltool
	virtual/pkgconfig"

src_prepare() {
	default
	vala_src_prepare
	eautoreconf
	gnome2_src_prepare
}

src_configure() {
	gnome2_src_configure
}

src_install() {
	default
	insinto /etc/lightdm/
	doins "${FILESDIR}/${PN}.conf"
}
