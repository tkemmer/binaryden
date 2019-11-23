# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools gnome2

DESCRIPTION="A GTK+3 timezone map widget"
HOMEPAGE="https://launchpad.net/timezonemap"
SRC_URI="https://launchpad.net/${PN}/trunk/${PV}/+download/lib${P}.tar.xz -> ${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

S="${WORKDIR}/lib${P}"

COMMON_DEPEND="
	dev-libs/glib:2
	dev-libs/gobject-introspection
	dev-libs/json-glib
	net-libs/libsoup:2.4=
	x11-libs/cairo
	x11-libs/gtk+:3[X]"

RDEPEND="${COMMON_DEPEND}"

DEPEND="${COMMON_DEPEND}
	virtual/pkgconfig"

src_prepare() {
	default
	eautoreconf
	gnome2_src_prepare
}

src_configure() {
	gnome2_src_configure
}
