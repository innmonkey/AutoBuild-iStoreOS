# iStoreOS 固件 | 定制的麻烦自行 fork 修改

[![iStore使用文档](https://img.shields.io/badge/使用文档-iStore%20OS-brightgreen?style=flat-square)](https://doc.linkease.com/zh/guide/istoreos)  [![固件源码](https://img.shields.io/badge/固件源码-iStoreOS%2023.05-brightgreen.svg?style=flat-square)](https://github.com/istoreos/istoreos)  ![支持设备](https://img.shields.io/badge/支持设备-x86/64-brightgreen.svg?style=flat-square)  [![最新固件下载](https://img.shields.io/github/v/release/innmonkey/AutoBuild-iStoreOS?style=flat-square&label=最新固件下载&color=brightgreen)](../../releases/latest)


## 功能特性

### 背景自定义
- 自定义背景和网页图标

### 添加新支持
- x86 支持 VMDK

### 移除无用功能
- 移除 samba4
- 移除 统一文件共享
- 移除 NFS挂载
- 移除 挂载网络共享
- 移除 硬盘休眠
- 移除 网络唤醒
- 移除 bootstrap主题
- 移除 应用过滤
  
### 添加新功能
- 添加 OpenClash
- 添加 ADGuardHome
- 添加 Mosdns
- 添加 Pushbot
- 添加 qbittorrent
- 添加 transmission
- 添加 Jellyfin

## 默认配置
- IP: `http://192.168.0.2` or `http://iStoreOS.lan/`
- 用户名: `root`
- 密码: `password`
- 如果设备只有一个网口，则此网口就是 `LAN` , 如果大于一个网口, 默认第一个网口是 `WAN` 口, 其它都是 `LAN`
- 如果要修改 `LAN` 口 `IP` , 首页有个内网设置，或者用命令 `quickstart` 修改
- 编译时间不定, 每月3-4次，`Release` 中只保留最近3个版本


## 鸣谢
- [dracon-china/customize-istoreos-actions](https://github.com/dracon-china/customize-istoreos-actions)
- [P3TERX/Actions-OpenWrt](https://github.com/P3TERX/Actions-OpenWrt)
- [OpenWrt](https://github.com/openwrt/openwrt)
- [istoreos](https://github.com/istoreos/istoreos)
- [GitHub Actions](https://github.com/features/actions)
- [stupidloud/cachewrtbuild](https://github.com/stupidloud/cachewrtbuild)
- [softprops/action-gh-release](https://github.com/softprops/action-gh-release)
- [GitRML/delete-workflow-runs](https://github.com/GitRML/delete-workflow-runs)
- [dev-drprasad/delete-older-releases](https://github.com/dev-drprasad/delete-older-releases)
- [peter-evans/repository-dispatch](https://github.com/peter-evans/repository-dispatch)
