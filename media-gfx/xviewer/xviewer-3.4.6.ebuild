# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson gnome2-utils strip-linguas

DESCRIPTION="A generic image viewer"
HOMEPAGE="https://github.com/linuxmint/xviewer"
SRC_URI="https://github.com/linuxmint/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="gtk-doc exif jpeg lcms svg xmp"

DEPEND="
	dev-libs/glib:2
	dev-libs/libpeas[gtk]
	gnome-extra/cinnamon-desktop:=
	x11-libs/gdk-pixbuf:2
	x11-libs/gtk+:3[X]
	x11-libs/xapp

	exif? (
		media-libs/libexif
	)
	jpeg? (
		media-libs/libjpeg-turbo:=
	)
	lcms? (
		media-libs/lcms:2
	)
	svg? (
		gnome-base/librsvg:2
	)
	xmp? (
		media-libs/exempi:2=
	)
"
RDEPEND="
	${DEPEND}
"
BDEPEND="
	dev-util/intltool
	virtual/pkgconfig

	gtk-doc? (
		dev-util/gtk-doc
	)
"

src_prepare() {
	default

	strip-linguas -i "${S}/po" || die
	echo $LINGUAS > "${S}/po/LINGUAS" || die
	echo $LINGUAS > "${S}/help/LINGUAS" || die
}

src_configure() {
	local emesonargs=(
		$(meson_feature xmp exempi)
		$(meson_feature exif)
		$(meson_feature jpeg)
		$(meson_feature lcms)
		$(meson_feature svg rsvg)
		$(meson_use gtk-doc docs)
	)
	meson_src_configure
}

pkg_postinst() {
	xdg_icon_cache_update
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_icon_cache_update
	gnome2_schemas_update
}
