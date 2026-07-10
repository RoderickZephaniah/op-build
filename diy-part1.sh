#!/bin/bash
# 写入kenzo small源到文件头部，避免重复冲突
sed -i '1i src-git kenzo https://github.com/kenzok8/openwrt-packages' feeds.conf.default
sed -i '2i src-git small https://github.com/kenzok8/small' feeds.conf.default

# 更新feed并删除冲突重复插件
./scripts/feeds update -a
rm -rf feeds/luci/applications/luci-app-mosdns
rm -rf feeds/packages/net/{alist,adguardhome,mosdns,xray*,v2ray*,sing*,smartdns} feeds/packages/utils/v2dat feeds/packages/lang/golang

# 替换golang 1.26版本
git clone https://github.com/kenzok8/golang -b 1.26 feeds/packages/lang/golang

# 安装所有feed包
./scripts/feeds install -a
