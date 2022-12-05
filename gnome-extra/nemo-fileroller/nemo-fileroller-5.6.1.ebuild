# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson

MY_PV="5.6.0"

DESCRIPTION="Nemo file-roller integration"
HOMEPAGE="https://projects.linuxmint.com/cinnamon/ https://github.com/linuxmint/nemo-extensions"
SRC_URI="https://github.com/linuxmint/nemo-extensions/archive/${MY_PV}.tar.gz -> nemo-extensions-${MY_PV}.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~riscv ~x86"

DEPEND="
	>=dev-libs/glib-2.14.0
	>=gnome-extra/nemo-2.6
"
RDEPEND="
	${DEPEND}
	app-arch/file-roller
"
PATCHES=(
	"${FILESDIR}/${PN}-5.6.0-to-5.6.1.patch"
)

S="${WORKDIR}/nemo-extensions-${MY_PV}/${PN}"
