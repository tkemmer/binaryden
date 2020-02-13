# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
COMMIT=f4ae13955b36213a84e40e42e88b0b9ffc9d0420

inherit cmake

DESCRIPTION="NVIDIA GPUs htop like monitoring tool"
HOMEPAGE="https://github.com/syllo/nvtop"
SRC_URI="https://github.com/syllo/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="sys-libs/ncurses:=[tinfo,unicode]"
BDEPEND="dev-util/nvidia-cuda-toolkit"
RDEPEND="x11-drivers/nvidia-drivers[X]"

RESTRICT="test"

S="${WORKDIR}/${PN}-${COMMIT}"
