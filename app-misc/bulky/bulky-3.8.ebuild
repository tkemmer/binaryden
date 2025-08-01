# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PLOCALES="aa am ar ast az be bg bn br ca ca@valencia ckb cs cy da de el en_CA en_GB eo es et eu fa fi fil fr fr_CA gl gu he hi hr hu ia id ie ig is it ja ka kab kk ko ku la lt lv ml ms nb nds nl nn oc pa pl pt pt_BR ro ru rue sid sk sl sn so sq sr sr@ijekavian sr@latin sv szl ta te tg th tr tt uk ur uz vi zh_CN zh_HK zh_TW"
PYTHON_COMPAT=( python3_{10..13} )

inherit python-single-r1 gnome2-utils plocale

DESCRIPTION="Bulk Renamer"
HOMEPAGE="https://github.com/linuxmint/bulky"
SRC_URI="
	https://github.com/linuxmint/${PN}/archive/refs/tags/${PV}.tar.gz
		-> ${P}.gh.tar.gz
"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

BDEPEND="
	sys-devel/gettext
"
RDEPEND="
	${PYTHON_DEPS}
	$(python_gen_cond_dep '
		dev-python/pygobject[${PYTHON_USEDEP}]
		dev-python/setproctitle[${PYTHON_USEDEP}]
		dev-python/unidecode[${PYTHON_USEDEP}]
	' 'python*' )
"

src_prepare() {
	default

	disable_locale() {
		local fname="po/${PN}-${1}.po"
		if [[ -e "${fname}" ]] ; then
			rm "${fname}" || die
		fi
	}
	plocale_find_changes po "${PN}-" ".po"
	plocale_for_each_disabled_locale disable_locale
}

src_install() {
	python_scriptinto /usr/bin
	python_newscript usr/lib/bulky/bulky.py bulky

	insinto /usr
	doins -r usr/share

	install_locale() {
		insinto /usr/share/locale
		doins -r usr/share/locale/${1}
	}
	plocale_for_each_locale install_locale
}

pkg_postinst() {
	gnome2_schemas_update
}

pkg_postrm() {
	gnome2_schemas_update
}
