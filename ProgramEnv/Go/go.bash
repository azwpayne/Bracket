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

export GO111MODULE='on'
export GOPROXY='https://goproxy.cn,direct'
export GOROOT='/usr/local/go'
export GOPATH='/www/workspace/go'
export PATH=${GOROOT}/bin:${GOPATH}/bin:$PATH

source /etc/profile
go env -w GOPROXY="https://goproxy.cn,direct"
go env GOPROXY
go env

go install github.com/golang/protobuf/protoc-gen-go@latest
echo "Successful Installation ${PKG} ..."
exit 0
