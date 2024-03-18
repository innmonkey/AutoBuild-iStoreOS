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

# 修改主机名字，把 iStore OS 修改你喜欢的就行（不能纯数字或者使用中文）
sed -i 's/OpenWrt/iStoreOS/g' package/base-files/files/bin/config_generate

# 移除要替换的包
#rm -rf feeds/packages/net/mosdns
rm -rf feeds/packages/net/v2ray-geodata
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
#git clone --depth=1 https://github.com/sbwml/luci-app-mosdns package/mosdns
git clone https://github.com/sbwml/luci-app-mosdns -b v5 package/mosdns
git clone https://github.com/sbwml/v2ray-geodata package/v2ray-geodata

git_sparse_clone master https://github.com/kiddin9/openwrt-packages luci-app-adguardhome
git_sparse_clone master https://github.com/kiddin9/openwrt-packages luci-app-openclash
git_sparse_clone master https://github.com/kiddin9/openwrt-packages luci-app-jellyfin
git_sparse_clone master https://github.com/kiddin9/openwrt-packages luci-app-xunlei
#git_sparse_clone master https://github.com/kiddin9/openwrt-packages luci-app-mosdns
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

# pushbot
CONFIG_PACKAGE_luci-app-pushbot=y

# Jellyfin
CONFIG_PACKAGE_luci-app-jellyfin=y

# xunlei
CONFIG_PACKAGE_luci-app-xunlei=y

# qbittorrent
CONFIG_PACKAGE_luci-app-qbittorrent=y

# transmission
CONFIG_PACKAGE_luci-app-transmission=y

# uhttpd
CONFIG_PACKAGE_luci-app-uhttpd=y
" >> .config

# 调整 transmission 到 nas 菜单
#sed -i 's/services/nas/g' feeds/luci/applications/luci-app-transmission/root/usr/share/luci/menu.d/luci-app-transmission.json

# 调整 jellyfin 到 nas 菜单
#sed -i 's/services/nas/g' package/luci-app-jellyfin/luasrc/controller/*.lua
#sed -i 's/services/nas/g' package/luci-app-jellyfin/luasrc/model/cbi/*.lua

# 调整 迅雷 到 nas 菜单
#sed -i 's/services/nas/g' package/luci-app-xunlei/luasrc/controller/*.lua

# 调整 linkease 到 nas 菜单
#sed -i 's/services/nas/g' feeds/linkease_nas_luci/luci/luci-app-linkease/luasrc/controller/*.lua
#sed -i 's/services/nas/g' feeds/linkease_nas_luci/luci/luci-app-linkease/luasrc/view/*.htm

# 更改 Argon 主题背景
cp -f $GITHUB_WORKSPACE/bg1.jpg feeds/third/luci-theme-argon/htdocs/luci-static/argon/img/bg1.jpg
