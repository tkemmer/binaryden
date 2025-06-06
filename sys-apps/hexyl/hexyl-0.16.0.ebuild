# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	aho-corasick@1.1.3
	anstream@0.6.17
	anstyle-parse@0.2.6
	anstyle-query@1.1.2
	anstyle-wincon@3.0.6
	anstyle@1.0.9
	anyhow@1.0.91
	assert_cmd@2.0.16
	autocfg@1.4.0
	bitflags@2.6.0
	bstr@1.10.0
	clap@4.5.20
	clap_builder@4.5.20
	clap_derive@4.5.18
	clap_lex@0.7.2
	colorchoice@1.0.3
	const_format@0.2.33
	const_format_proc_macros@0.2.33
	diff@0.1.13
	difflib@0.4.0
	doc-comment@0.3.3
	errno@0.3.9
	float-cmp@0.9.0
	heck@0.5.0
	is_ci@1.2.0
	is_terminal_polyfill@1.70.1
	libc@0.2.161
	linux-raw-sys@0.4.14
	memchr@2.7.4
	normalize-line-endings@0.3.0
	num-traits@0.2.19
	owo-colors@4.1.0
	predicates-core@1.0.8
	predicates-tree@1.0.11
	predicates@3.1.2
	pretty_assertions@1.4.1
	proc-macro2@1.0.89
	quote@1.0.37
	regex-automata@0.4.8
	regex-syntax@0.8.5
	regex@1.11.1
	rustix@0.38.38
	serde@1.0.214
	serde_derive@1.0.214
	strsim@0.11.1
	supports-color@3.0.1
	syn@2.0.85
	terminal_size@0.4.0
	termtree@0.4.1
	thiserror-impl@1.0.65
	thiserror@1.0.65
	unicode-ident@1.0.13
	unicode-xid@0.2.6
	utf8parse@0.2.2
	wait-timeout@0.2.0
	windows-sys@0.52.0
	windows-sys@0.59.0
	windows-targets@0.52.6
	windows_aarch64_gnullvm@0.52.6
	windows_aarch64_msvc@0.52.6
	windows_i686_gnu@0.52.6
	windows_i686_gnullvm@0.52.6
	windows_i686_msvc@0.52.6
	windows_x86_64_gnu@0.52.6
	windows_x86_64_gnullvm@0.52.6
	windows_x86_64_msvc@0.52.6
	yansi@1.0.1
"

inherit cargo

DESCRIPTION="A command-line hex viewer"
HOMEPAGE="https://github.com/sharkdp/hexyl"
SRC_URI="
	https://github.com/sharkdp/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	${CARGO_CRATE_URIS}
"

LICENSE="|| ( Apache-2.0 MIT )"
# Dependent crate licenses
LICENSE+=" Apache-2.0 ISC MIT Unicode-DFS-2016 ZLIB"
SLOT="0"
KEYWORDS="~amd64"

DOCS=( README.md CHANGELOG.md )

src_install() {
	cargo_src_install
	einstalldocs
}
