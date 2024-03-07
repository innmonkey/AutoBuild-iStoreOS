# iStore OS 固件 | 定制的麻烦自行 fork 修改

[![iStore使用文档](https://img.shields.io/badge/使用文档-iStore%20OS-brightgreen?style=flat-square)](https://doc.linkease.com/zh/guide/istoreos)  ![支持设备](https://img.shields.io/badge/支持设备-x86/64-blue.svg?style=flat-square)  [![最新固件下载](https://img.shields.io/github/v/release/innmonkey/AutoBuild-iStoreOS?style=flat-square&label=最新固件下载)](../../releases/latest)

## 功能特性

- x86 支持 VMDK
- 移除 samba4
- 移除 统一文件共享
- 移除 NFS挂载
- 移除 挂载网络共享
- 移除 磁盘阵列
- 移除 bootstrap 主题
- 添加 关机
- 添加 OpenClash
- 添加 ADGuardHome
- 添加 Mosdns
- 添加 Pushbot
- 添加 qbittorrent
- 添加 transmission


## 默认配置

- IP: `http://192.168.0.2` or `http://iStoreOS.lan/`
- 用户名: `root`
- 密码: `password`
- 如果设备只有一个网口，则此网口就是 `LAN` , 如果大于一个网口, 默认第一个网口是 `WAN` 口, 其它都是 `LAN`
- 如果要修改 `LAN` 口 `IP` , 首页有个内网设置，或者用命令 `quickstart` 修改
- 北京时间每天 `0:00` 定时编译, `Release` 中只保留最新版本
- 历史版本在 `Actions` 中选择一个已经运行完成且成功的 `workflow` 在页面底部可以看到 `Artifacts`, `Artifacts` 需要登录 Github 才能下载


## 鸣谢

- [dracon-china/customize-istoreos-actions](https://github.com/dracon-china/customize-istoreos-actions)
- [istoreos](https://github.com/istoreos/istoreos)
- [P3TERX/Actions-OpenWrt](https://github.com/P3TERX/Actions-OpenWrt)
- [Microsoft Azure](https://azure.microsoft.com)
- [GitHub Actions](https://github.com/features/actions)
- [OpenWrt](https://github.com/openwrt/openwrt)
- [Lean&#39;s OpenWrt](https://github.com/coolsnowwolf/lede)
- [tmate](https://github.com/tmate-io/tmate)
- [mxschmitt/action-tmate](https://github.com/mxschmitt/action-tmate)
- [csexton/debugger-action](https://github.com/csexton/debugger-action)
- [Cowtransfer](https://cowtransfer.com)
- [WeTransfer](https://wetransfer.com/)
- [Mikubill/transfer](https://github.com/Mikubill/transfer)
- [softprops/action-gh-release](https://github.com/softprops/action-gh-release)
- [ActionsRML/delete-workflow-runs](https://github.com/ActionsRML/delete-workflow-runs)
- [dev-drprasad/delete-older-releases](https://github.com/dev-drprasad/delete-older-releases)
- [peter-evans/repository-dispatch](https://github.com/peter-evans/repository-dispatch)
