# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit meson gnome2-utils pax-utils xdg-utils

DESCRIPTION="Linux Mint's fork of gjs for Cinnamon"
HOMEPAGE="https://projects.linuxmint.com/cinnamon/"
SRC_URI="https://github.com/linuxmint/cjs/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT || ( MPL-1.1 LGPL-2+ GPL-2+ )"
SLOT="0"
IUSE="+cairo examples test"
KEYWORDS="~amd64 ~x86"
RESTRICT="!test? ( test )"

RDEPEND="
	dev-lang/spidermonkey:78
	>=dev-libs/glib-2.58:2
	>=dev-libs/gobject-introspection-1.58.3:=
	sys-libs/readline:0=
	dev-libs/libffi:0=
	cairo? ( x11-libs/cairo[X,glib] )
"
DEPEND="${RDEPEND}"
BDEPEND="
	sys-devel/gettext
	virtual/pkgconfig
"

src_configure() {
	# FIXME: add systemtap/dtrace support, like in glib:2
	# FIXME: --enable-systemtap installs files in ${D}/${D} for some reason
	local emesonargs=(
		-Ddtrace=false
		-Dreadline=enabled
		-Dskip_dbus_tests=true
		-Dskip_gtk_tests=true
		-Dsystemtap=false
		$(meson_feature cairo)
		$(meson_use test installed_tests)
	)
	meson_src_configure
}

src_install() {
	meson_src_install

	if use examples; then
		docinto examples
		dodoc "${S}"/examples/*
	fi

	# Required for cjs-console to run correctly on PaX systems
	pax-mark mr "${ED}/usr/bin/cjs-console"
}

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_pkg_postrm
	gnome2_schemas_update
}

