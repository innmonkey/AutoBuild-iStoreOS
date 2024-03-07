#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# 修改openwrt登陆地址,把下面的 10.0.0.1 修改成你想要的就可以了
sed -i 's/192.168.1.1/192.168.0.2/g' package/base-files/files/bin/config_generate
# 修改 子网掩码
#sed -i 's/255.255.255.0/255.255.0.0/g' package/base-files/files/bin/config_generate

# 修改主机名字，把 iStore OS 修改你喜欢的就行（不能纯数字或者使用中文）
# sed -i 's/OpenWrt/iStore OS/g' package/base-files/files/bin/config_generate

# 更改 Argon 主题背景
#cp -f $GITHUB_WORKSPACE/bg1.jpg package/luci-theme-argon/htdocs/luci-static/argon/img/bg1.jpg

# ttyd 自动登录
# sed -i "s?/bin/login?/usr/libexec/login.sh?g" ${GITHUB_WORKSPACE}/openwrt/package/feeds/packages/ttyd/files/ttyd.config

# 移除要替换的包
#rm -rf feeds/luci/themes/luci-theme-argon

# 添加软件
git clone --depth=1 https://github.com/kongfl888/luci-app-adguardhome package/luci-app-adguardhome
git clone --depth=1 https://github.com/sbwml/luci-app-mosdns package/luci-app-mosdns
git clone --depth=1 https://github.com/zzsj0928/luci-app-pushbot package/luci-app-pushbot
git clone --depth=1 https://github.com/vernesong/OpenClash package/luci-app-openclash
#git clone --depth=1 -b 18.06 https://github.com/jerrykuku/luci-theme-argon package/luci-theme-argon

echo "
# 额外组件
CONFIG_GRUB_IMAGES=y
CONFIG_VMDK_IMAGES=y

# 关机
CONFIG_PACKAGE_luci-app-poweroff=y
CONFIG_PACKAGE_luci-i18n-poweroff-zh-cn=y

# openclash
CONFIG_PACKAGE_luci-app-openclash=y
CONFIG_PACKAGE_luci-i18n-openclash-zh-cn=y

# adguardhome
CONFIG_PACKAGE_adguardhome=y
CONFIG_PACKAGE_luci-app-adguardhome=y
CONFIG_PACKAGE_luci-i18n-adguardhome-zh-cn=y

# mosdns
CONFIG_PACKAGE_mosdns=y
CONFIG_PACKAGE_luci-app-mosdns=y
CONFIG_PACKAGE_luci-i18n-mosdns-zh-cn=y

#pushbot
CONFIG_PACKAGE_luci-app-pushbot=y

#qbittorrent
CONFIG_PACKAGE_luci-app-qbittorrent=y
CONFIG_PACKAGE_luci-i18n-qbittorrent-zh-cn=y
CONFIG_PACKAGE_qbittorrent=y

#transmission
CONFIG_PACKAGE_luci-app-transmission=y
CONFIG_PACKAGE_luci-i18n-transmission-zh-cn=y
CONFIG_PACKAGE_transmission-daemon-openssl=y
CONFIG_PACKAGE_transmission-web-control=y

# rclone
#CONFIG_PACKAGE_rclone=y
#CONFIG_PACKAGE_fuse3-utils=y

" >> .config

# 移除 ddns 和 ddnsto
#sed -i 's/CONFIG_PACKAGE_ddns-scripts=y/CONFIG_PACKAGE_ddns-scripts=n/' .config
#sed -i 's/CONFIG_PACKAGE_ddns-scripts-cloudflare=y/CONFIG_PACKAGE_ddns-scripts-cloudflare=n/' .config
#sed -i 's/CONFIG_PACKAGE_ddns-scripts-dnspod=y/CONFIG_PACKAGE_ddns-scripts-dnspod=n/' .config
#sed -i 's/CONFIG_PACKAGE_ddns-scripts-services=y/CONFIG_PACKAGE_ddns-scripts-services=n/' .config
#sed -i 's/CONFIG_PACKAGE_ddns-scripts_aliyun=y/CONFIG_PACKAGE_ddns-scripts_aliyun=n/' .config
#sed -i 's/CONFIG_PACKAGE_luci-app-ddns=y/CONFIG_PACKAGE_luci-app-ddns=n/' .config
#sed -i 's/CONFIG_PACKAGE_luci-i18n-ddns-zh-cn=y/CONFIG_PACKAGE_luci-i18n-ddns-zh-cn=n/' .config

#sed -i 's/CONFIG_PACKAGE_ddnsto=y/CONFIG_PACKAGE_ddnsto=n/' .config
#sed -i 's/CONFIG_PACKAGE_luci-app-ddnsto=y/CONFIG_PACKAGE_luci-app-ddnsto=n/' .config
#sed -i 's/CONFIG_PACKAGE_luci-i18n-ddnsto-zh-cn=y/CONFIG_PACKAGE_luci-i18n-ddnsto-zh-cn=n/' .config

#移除samba4
sed -i 's/CONFIG_PACKAGE_luci-i18n-samba4-zh-cn=y/CONFIG_PACKAGE_luci-i18n-samba4-zh-cn=n/' .config
sed -i 's/CONFIG_PACKAGE_luci-app-samba4=y/CONFIG_PACKAGE_luci-app-samba4=n/' .config
sed -i 's/CONFIG_SAMBA4_SERVER_AVAHI=y/CONFIG_SAMBA4_SERVER_AVAHI=n/' .config
sed -i 's/CONFIG_SAMBA4_SERVER_NETBIOS=y/CONFIG_SAMBA4_SERVER_NETBIOS=n/' .config
sed -i 's/CONFIG_SAMBA4_SERVER_VFS=y/CONFIG_SAMBA4_SERVER_VFS=n/' .config
sed -i 's/CONFIG_SAMBA4_SERVER_WSDD2=y/CONFIG_SAMBA4_SERVER_WSDD2=n/' .config
sed -i 's/CONFIG_PACKAGE_samba4-libs=y/CONFIG_PACKAGE_samba4-libs=n/' .config
sed -i 's/CONFIG_PACKAGE_samba4-server=y/CONFIG_PACKAGE_samba4-server=n/' .config

#移除统一文件共享
sed -i 's/CONFIG_PACKAGE_luci-app-unishare=y/CONFIG_PACKAGE_luci-app-unishare=n/' .config
sed -i 's/CONFIG_PACKAGE_luci-i18n-unishare-zh-cn=y/CONFIG_PACKAGE_luci-i18n-unishare-zh-cn=n/' .config
sed -i 's/CONFIG_PACKAGE_unishare=y/CONFIG_PACKAGE_unishare=n/' .config

#移除NFS
sed -i 's/CONFIG_PACKAGE_luci-app-nfs=y/CONFIG_PACKAGE_luci-app-nfs=n/' .config
sed -i 's/CONFIG_PACKAGE_luci-i18n-nfs-zh-cn=y/CONFIG_PACKAGE_luci-i18n-nfs-zh-cn=n/' .config
sed -i 's/CONFIG_PACKAGE_nfs-kernel-server=y/CONFIG_PACKAGE_nfs-kernel-server=n/' .config
sed -i 's/CONFIG_PACKAGE_nfs-kernel-server-utils=y/CONFIG_PACKAGE_nfs-kernel-server-utils=n/' .config
sed -i 's/CONFIG_PACKAGE_nfs-utils=y/CONFIG_PACKAGE_nfs-utils=n/' .config
sed -i 's/CONFIG_PACKAGE_nfs-utils-libs=y/CONFIG_PACKAGE_nfs-utils-libs=n/' .config
sed -i 's/CONFIG_NFS_KERNEL_SERVER_V4=y/CONFIG_NFS_KERNEL_SERVER_V4=n/' .config
sed -i 's/CONFIG_PACKAGE_kmod-fs-nfs=y/CONFIG_PACKAGE_kmod-fs-nfs=n/' .config
sed -i 's/CONFIG_PACKAGE_kmod-fs-nfs-common=y/CONFIG_PACKAGE_kmod-fs-nfs-common=n/' .config
sed -i 's/CONFIG_PACKAGE_kmod-fs-nfs-common-rpcsec=y/CONFIG_PACKAGE_kmod-fs-nfs-common-rpcsec=n/' .config
sed -i 's/CONFIG_PACKAGE_kmod-fs-nfs-v3=y/CONFIG_PACKAGE_kmod-fs-nfs-v3=n/' .config
sed -i 's/CONFIG_PACKAGE_kmod-fs-nfs-v4=y/CONFIG_PACKAGE_kmod-fs-nfs-v4=n/' .config
sed -i 's/CONFIG_PACKAGE_kmod-fs-nfsd=y/CONFIG_PACKAGE_kmod-fs-nfsd=n/' .config

#移除挂载网络共享
sed -i 's/CONFIG_PACKAGE_luci-app-cifs-mount=y/CONFIG_PACKAGE_luci-app-cifs-mount=n/' .config
sed -i 's/CONFIG_PACKAGE_luci-i18n-cifs-mount-zh-cn=y/CONFIG_PACKAGE_luci-i18n-cifs-mount-zh-cn=n/' .config
sed -i 's/CONFIG_PACKAGE_cifsmount=y/CONFIG_PACKAGE_cifsmount=n/' .config
sed -i 's/CONFIG_PACKAGE_kmod-fs-cifs=y/CONFIG_PACKAGE_kmod-fs-cifs=n/' .config

#移除磁盘阵列
sed -i 's/CONFIG_PACKAGE_kmod-dm-raid=y/CONFIG_PACKAGE_kmod-dm-raid=n/' .config
sed -i 's/CONFIG_PACKAGE_kmod-lib-raid6=y/CONFIG_PACKAGE_kmod-lib-raid6=n/' .config
sed -i 's/CONFIG_PACKAGE_kmod-md-raid0=y/CONFIG_PACKAGE_kmod-md-raid0=n/' .config
sed -i 's/CONFIG_PACKAGE_kmod-md-raid1=y/CONFIG_PACKAGE_kmod-md-raid1=n/' .config
sed -i 's/CONFIG_PACKAGE_kmod-md-raid10=y/CONFIG_PACKAGE_kmod-md-raid10=n/' .config
sed -i 's/CONFIG_PACKAGE_kmod-md-raid456=y/CONFIG_PACKAGE_kmod-md-raid456=n/' .config
sed -i 's/CONFIG_PACKAGE_kmod-scsi-raid=y/CONFIG_PACKAGE_kmod-scsi-raid=n/' .config

# 移除 bootstrap 主题
sed -i 's/CONFIG_PACKAGE_luci-theme-bootstrap=y/CONFIG_PACKAGE_luci-theme-bootstrap=n/' .config

# 移除网卡驱动
# sed -i 's/CONFIG_PACKAGE_kmod-ath=y/CONFIG_PACKAGE_kmod-ath=n/' .config
# sed -i 's/CONFIG_PACKAGE_kmod-ath10k=y/CONFIG_PACKAGE_kmod-ath10k=n/' .config
# sed -i 's/CONFIG_PACKAGE_ath10k-board-qca9888=y/CONFIG_PACKAGE_ath10k-board-qca9888=n/' .config
# sed -i 's/CONFIG_PACKAGE_ath10k-board-qca988x=y/CONFIG_PACKAGE_ath10k-board-qca988x=n/' .config
# sed -i 's/CONFIG_PACKAGE_ath10k-board-qca9984=y/CONFIG_PACKAGE_ath10k-board-qca9984=n/' .config
# sed -i 's/CONFIG_PACKAGE_ath10k-firmware-qca9888=y/CONFIG_PACKAGE_ath10k-firmware-qca9888=n/' .config
# sed -i 's/CONFIG_PACKAGE_ath10k-firmware-qca988x=y/CONFIG_PACKAGE_ath10k-firmware-qca988x=n/' .config
# sed -i 's/CONFIG_PACKAGE_ath10k-firmware-qca9984=y/CONFIG_PACKAGE_ath10k-firmware-qca9984=n/' .config

# sed -i 's/CONFIG_PACKAGE_iw=y/CONFIG_PACKAGE_iw=n/' .config
# sed -i 's/CONFIG_PACKAGE_iwinfo=y/CONFIG_PACKAGE_iwinfo=n/' .config
# sed -i 's/CONFIG_PACKAGE_kmod-iwlwifi=y/CONFIG_PACKAGE_kmod-iwlwifi=n/' .config
# sed -i 's/CONFIG_PACKAGE_iwlwifi-firmware-ax101=y/CONFIG_PACKAGE_iwlwifi-firmware-ax101=n/' .config
# sed -i 's/CONFIG_PACKAGE_iwlwifi-firmware-ax200=y/CONFIG_PACKAGE_iwlwifi-firmware-ax200=n/' .config
# sed -i 's/CONFIG_PACKAGE_iwlwifi-firmware-ax201=y/CONFIG_PACKAGE_iwlwifi-firmware-ax201=n/' .config
# sed -i 's/CONFIG_PACKAGE_iwlwifi-firmware-ax210=y/CONFIG_PACKAGE_iwlwifi-firmware-ax210=n/' .config
# sed -i 's/CONFIG_PACKAGE_kmod-rtl8192c-common=y/CONFIG_PACKAGE_kmod-rtl8192c-common=n/' .config
# sed -i 's/CONFIG_PACKAGE_kmod-rtl8192cu=y/CONFIG_PACKAGE_kmod-rtl8192cu=n/' .config
# sed -i 's/CONFIG_PACKAGE_kmod-rtl8192de=y/CONFIG_PACKAGE_kmod-rtl8192de=n/' .config
# sed -i 's/CONFIG_PACKAGE_kmod-rtl8192se=y/CONFIG_PACKAGE_kmod-rtl8192se=n/' .config
# sed -i 's/CONFIG_PACKAGE_kmod-rtl8812au-ct=y/CONFIG_PACKAGE_kmod-rtl8812au-ct=n/' .config
# sed -i 's/CONFIG_PACKAGE_kmod-rtl8821ae=y/CONFIG_PACKAGE_kmod-rtl8821ae=n/' .config
# sed -i 's/CONFIG_PACKAGE_kmod-rtl8xxxu=y/CONFIG_PACKAGE_kmod-rtl8xxxu=n/' .config
# sed -i 's/CONFIG_PACKAGE_kmod-rtlwifi=y/CONFIG_PACKAGE_kmod-rtlwifi=n/' .config
# sed -i 's/CONFIG_PACKAGE_kmod-rtlwifi-btcoexist=y/CONFIG_PACKAGE_kmod-rtlwifi-btcoexist=n/' .config
# sed -i 's/CONFIG_PACKAGE_kmod-rtlwifi-pci=y/CONFIG_PACKAGE_kmod-rtlwifi-pci=n/' .config
# sed -i 's/CONFIG_PACKAGE_kmod-rtlwifi-usb=y/CONFIG_PACKAGE_kmod-rtlwifi-usb=n/' .config
# sed -i 's/CONFIG_PACKAGE_kmod-rtw88=y/CONFIG_PACKAGE_kmod-rtw88=n/' .config

# sed -i 's/CONFIG_PACKAGE_kmod-mt7915e=y/CONFIG_PACKAGE_kmod-mt7915e=n/' .config

# sed -i 's/CONFIG_PACKAGE_kmod-mt7921-common=y/CONFIG_PACKAGE_kmod-mt7921-common=n/' .config
# sed -i 's/CONFIG_PACKAGE_kmod-mt7921-firmware=y/CONFIG_PACKAGE_kmod-mt7921-firmware=n/' .config
# sed -i 's/CONFIG_PACKAGE_kmod-mt7921e=y/CONFIG_PACKAGE_kmod-mt7921e=n/' .config
# sed -i 's/CONFIG_PACKAGE_kmod-mt7921u=y/CONFIG_PACKAGE_kmod-mt7921u=n/' .config
