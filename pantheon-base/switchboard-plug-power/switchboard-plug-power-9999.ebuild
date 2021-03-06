# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

VALA_MIN_API_VERSION=0.22

inherit vala cmake-utils git-r3

DESCRIPTION="Control system power consumption using Switchboard."
HOMEPAGE="https://launchpad.net/switchboard-plug-power"
EGIT_REPO_URI="https://github.com/elementary/switchboard-plug-power.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="nls"

RDEPEND="
	dev-libs/glib:2
	>=pantheon-base/switchboard-2
	dev-libs/granite
	x11-libs/gtk+:3"
DEPEND="${RDEPEND}
	$(vala_depend)
	virtual/pkgconfig
	nls? ( sys-devel/gettext )"

src_prepare() {
	use nls || sed -i '/add_subdirectory (po)/d' CMakeLists.txt

	cmake-utils_src_prepare
	vala_src_prepare

	default
}

src_configure() {
	local mycmakeargs=(
		-DVALA_EXECUTABLE="${VALAC}"
	)
	cmake-utils_src_configure
}
