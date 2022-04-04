#!/usr/bin/env bash
# @author: payne
# @email: wuzhipeng1289690157@gmail.com
# Set up Go development environment

VERSION=1.18
PKG=go${VERSION}.linux-amd64.tar.gz
SRC="https://golang.google.cn/dl/${PKG}"
echo "Downloading ${SRC} ..."
sudo wget -c "${SRC}"
sudo tar -zxf "${PKG}" -C /usr/local/
sudo cat <<EOF >>/etc/profile
# config golang config
export GO111MODULE="on"
export GOPROXY=https://goproxy.cn,direct # 安装 Go 模块时，代理服务器设置
EOF


source /etc/profile
go env -w GOPROXY="https://goproxy.cn,direct"
go env GOPROXY
go env

go install github.com/golang/protobuf/protoc-gen-go@latest
echo "Successful Installation ${PKG} ..."
exit 0
