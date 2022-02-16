#!/usr/bin/env bash
# @author: payne
# @email: wuzhipeng1289690157@gmail.com
# Set up Go development environment

VERSION=1.17.6
PKG=go${VERSION}.linux-amd64.tar.gz
SRC="https://golang.google.cn/dl/${PKG}"
echo "Downloading ${SRC} ..."
sudo wget -c "${SRC}"
sudo tar -zxf "${PKG}" -C /usr/local/
sudo cat >> /etc/profile <<EOF
# config golang config
export PATH="/usr/local/go/bin:\$PATH"
export GOROOT=$GO_INSTALL_DIR/$GOVERSION # GOROOT 设置
export GOPATH=$WORKSPACE/golang # GOPATH 设置
export PATH=$GOROOT/bin:$GOPATH/bin:$PATH # 将 Go 语言自带的和通过 go install 安装的二进制文件加入到 PATH 路径中
export GO111MODULE="on"
export GOPROXY=https://goproxy.cn,direct # 安装 Go 模块时，代理服务器设置
export GOPRIVATE=
export GOSUMDB=off # 关闭校验 Go 依赖包的哈希值
EOF


source /etc/profile
go env -w GOPROXY="https://goproxy.cn,direct"
go env GOPROXY
go env

go install github.com/golang/protobuf/protoc-gen-go@latest
echo "Successful Installation ${PKG} ..."
exit 0
