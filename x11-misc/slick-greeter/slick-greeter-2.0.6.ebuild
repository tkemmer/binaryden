# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson gnome2-utils vala strip-linguas

DESCRIPTION="A slick-looking LightDM greeter"
HOMEPAGE="https://github.com/linuxmint/slick-greeter"
SRC_URI="https://github.com/linuxmint/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-libs/glib:2
	media-libs/freetype:=
	media-libs/libcanberra
	x11-libs/cairo
	x11-libs/gtk+:3[X]
	x11-libs/libXext
	x11-libs/pixman
	x11-misc/lightdm[introspection,vala]
"
RDEPEND="
	${DEPEND}
"
BDEPEND="
	$(vala_depend)
	dev-util/intltool
	virtual/pkgconfig
"

src_prepare() {
	vala_setup
	default

	strip-linguas -i "${S}/po" || die
	echo $LINGUAS > "${S}/po/LINGUAS" || die
}

src_configure() {
	meson_src_configure
}

src_install() {
	meson_src_install
	insinto /etc/lightdm/
	newins "${FILESDIR}/${PN}-1.8.conf" "${PN}.conf"
}

pkg_postinst() {
	xdg_icon_cache_update
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_icon_cache_update
	gnome2_schemas_update
}
