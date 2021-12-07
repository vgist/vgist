# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
MULTILIB_COMPAT=( abi_x86_64 abi_mips_n64 )

inherit unpacker desktop multilib-build xdg

DESCRIPTION="UOS wechat"
HOMEPAGE="https://www.chinauos.com/resource/download-professional"

KEYWORDS="-* ~amd64 ~arm64 ~mips"

SRC_URI="
	amd64? ( https://cdn-package-store6.deepin.com/appstore/pool/appstore/c/com.qq.weixin/com.qq.weixin_${PV}-2_amd64.deb )
	arm64? ( https://cdn-package-store6.deepin.com/appstore/pool/appstore/c/com.qq.weixin/com.qq.weixin_${PV}-2_arm64.deb )
	mips? ( https://cdn-package-store6.deepin.com/appstore/pool/appstore/c/com.qq.weixin/com.qq.weixin_${PV}-2_mips64el.deb )"

SLOT="0"
RESTRICT="bindist strip mirror"
LICENSE="MIT"
IUSE="big-endian"
REQUIRED_USE="
	arm64? ( !big-endian )
	mips? ( !big-endian )"

RDEPEND="
	dev-libs/nss[${MULTILIB_USEDEP}]
	gnome-base/gconf:2[${MULTILIB_USEDEP}]
	media-libs/alsa-lib:0[${MULTILIB_USEDEP}]
	media-libs/fontconfig:1.0[${MULTILIB_USEDEP}]
	net-print/cups:0[${MULTILIB_USEDEP}]
	x11-libs/cairo:0[${MULTILIB_USEDEP}]
	x11-libs/gdk-pixbuf:2[${MULTILIB_USEDEP}]
	x11-libs/gtk+:2[${MULTILIB_USEDEP}]
	x11-libs/libX11[${MULTILIB_USEDEP}]
	x11-libs/libXScrnSaver[${MULTILIB_USEDEP}]
	x11-libs/libXtst[${MULTILIB_USEDEP}]
	x11-libs/pango[${MULTILIB_USEDEP}]
	sys-apps/lsb-release
	sys-apps/bubblewrap
"

S="${WORKDIR}"

QA_PREBUILT="
	opt/wechat-uos/libffmpeg.so
	opt/wechat-uos/libnode.so
	opt/wechat-uos/resources/wcs.node
	opt/wechat-uos/wechat
	usr/lib/license/libuosdevicea.so
"

src_install() {
	dobin "${FILESDIR}"/wechat-uos

	insinto /usr/share/icons
	doins -r "${S}"/opt/apps/com.qq.weixin/entries/icons/hicolor
	insinto /usr/share/applications
	doins "${FILESDIR}"/wechat-uos.desktop

	insinto /usr/lib/license
	doins "${S}"/usr/lib/license/libuosdevicea.so

	insinto /opt/wechat-uos
	doins -r "${S}"/opt/apps/com.qq.weixin/files/*
	fperms 0755 /opt/wechat-uos/wechat

	insinto /opt/wechat-uos/crap
	doins "${FILESDIR}"/{uos-lsb,uos-release}

}
