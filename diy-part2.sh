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
sed -i 's/192.168.1.1/192.168.110.253/g' package/base-files/files/bin/config_generate

# 修改主机名字，把 iStore OS 修改你喜欢的就行（不能纯数字或者使用中文）
sed -i 's/OpenWrt/iStoreOS/g' package/base-files/files/bin/config_generate

# 移除要替换的包
rm -rf feeds/packages/net/mosdns
#cp -r -f ./feeds/第三方源的文件 ./feeds/packages/net/mosdns
rm -rf feeds/third_party/luci-app-LingTiGameAcc


# Git稀疏克隆，只克隆指定目录到本地
function git_sparse_clone() {
  branch="$1" repourl="$2" && shift 2
  git clone --depth=1 -b $branch --single-branch --filter=blob:none --sparse $repourl
  repodir=$(echo $repourl | awk -F '/' '{print $(NF)}')
  cd $repodir && git sparse-checkout set $@
  mv -f $@ ../package
  cd .. && rm -rf $repodir
}

# 添加额外插件
#git clone --depth=1 https://github.com/kongfl888/luci-app-adguardhome package/luci-app-adguardhome
git_sparse_clone master https://github.com/kiddin9/openwrt-packages luci-app-adguardhome
git_sparse_clone master https://github.com/kiddin9/openwrt-packages luci-app-openclash
git_sparse_clone master https://github.com/kiddin9/openwrt-packages luci-app-jellyfin
git_sparse_clone master https://github.com/kiddin9/openwrt-packages luci-app-xunlei
git_sparse_clone master https://github.com/kiddin9/openwrt-packages luci-app-mosdns
#git clone https://github.com/zzsj0928/luci-app-pushbot package/luci-app-pushbot
#git_sparse_clone master https://github.com/kiddin9/openwrt-packages luci-app-qbittorrent
#git_sparse_clone master https://github.com/kiddin9/openwrt-packages luci-app-transmission

echo "
# 额外组件
CONFIG_GRUB_IMAGES=y
CONFIG_VMDK_IMAGES=y

# openclash
CONFIG_PACKAGE_luci-app-openclash=y

# adguardhome
CONFIG_PACKAGE_luci-app-adguardhome=y

# mosdns
CONFIG_PACKAGE_luci-app-mosdns=y

#pushbot
CONFIG_PACKAGE_luci-app-pushbot=y

#Jellyfin
CONFIG_PACKAGE_luci-app-jellyfin=y

#xunlei
CONFIG_PACKAGE_luci-app-xunlei=y

#qbittorrent
CONFIG_PACKAGE_luci-app-qbittorrent=y

#transmission
CONFIG_PACKAGE_luci-app-transmission=y
" >> .config

# 移除S.M.A.R.T.
sed -i 's/CONFIG_PACKAGE_smartd=y/CONFIG_PACKAGE_smartd=n/' .config
sed -i 's/CONFIG_PACKAGE_smartmontools=y/CONFIG_PACKAGE_smartmontools=n/' .config

# 移除应用过滤
sed -i 's/CONFIG_PACKAGE_appfilter=y/CONFIG_PACKAGE_appfilter=n/' .config

#移除网络唤醒
sed -i 's/CONFIG_PACKAGE_luci-app-wol=y/CONFIG_PACKAGE_luci-app-wol=n/' .config
sed -i 's/CONFIG_PACKAGE_luci-i18n-wol-zh-cn=y/CONFIG_PACKAGE_luci-i18n-wol-zh-cn=n/' .config

#移除硬盘休眠
sed -i 's/CONFIG_PACKAGE_luci-app-hd-idle=y/CONFIG_PACKAGE_luci-app-hd-idle=n/' .config
sed -i 's/CONFIG_PACKAGE_hd-idle=y/CONFIG_PACKAGE_hd-idle=n/' .config
sed -i 's/CONFIG_PACKAGE_luci-i18n-hd-idle-zh-cn=y/CONFIG_PACKAGE_luci-i18n-hd-idle-zh-cn=n/' .config


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
sed -i 's/CONFIG_PACKAGE_kmod-md-mod=y/CONFIG_PACKAGE_kmod-md-mod=n/' .config
sed -i 's/CONFIG_PACKAGE_kmod-md-linear=y/CONFIG_PACKAGE_kmod-md-linear=n/' .config

# 移除 bootstrap 主题
sed -i 's/CONFIG_PACKAGE_luci-theme-bootstrap=y/CONFIG_PACKAGE_luci-theme-bootstrap=n/' .config

# 调整 transmission 到 nas 菜单
sed -i 's/services/nas/g' feeds/luci/applications/luci-app-transmission/root/usr/share/luci/menu.d/luci-app-transmission.json

# 调整 jellyfin 到 nas 菜单
#sed -i 's/services/nas/g' package/luci-app-jellyfin/luasrc/controller/*.lua
#sed -i 's/services/nas/g' package/luci-app-jellyfin/luasrc/model/cbi/v2ray_server/*.lua
#sed -i 's/services/nas/g' package/luci-app-jellyfin/luasrc/view/v2ray_server/*.htm

# 调整 迅雷 到 nas 菜单
#sed -i 's/services/nas/g' package/luci-app-xunlei/luasrc/controller/*.lua
#sed -i 's/services/nas/g' package/luci-app-xunlei/luasrc/model/cbi/v2ray_server/*.lua
#sed -i 's/services/nas/g' package/luci-app-xunlei/luasrc/view/v2ray_server/*.htm

# 更改 Argon 主题背景
cp -f $GITHUB_WORKSPACE/bg1.jpg feeds/third/luci-theme-argon/htdocs/luci-static/argon/img/bg1.jpg
