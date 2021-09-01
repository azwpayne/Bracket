#!/usr/bin/env bash
# author: payne
# email: wuzhipeng1289690157@gmail.com
# Set up golang development environment

# install golang
## 1.download go package
version=1.16.6
pkg=go${version}.linux-amd64.tar.gz
src=https://golang.google.cn/dl/$pkg
echo "Downloading $pkg ..."
sudo wget $src
sudo tar -zxvf $pkg -C /opt
## 2.create Soft link
sudo ln -s /opt/go/ /usr/local/go
## 3. Add the PATH environment variable
sudo echo "export PATH=\$PATH:/usr/local/go/bin" >> /etc/profile && source /etc/profile
## 4.Add the GOPROXY
echo "$(go env GOPROXY)"
sudo go env -w GOPROXY=https://goproxy.cn,direct
echo "$(go env GOPROXY)"
echo "$(go env)"

GOROOT="/usr/local/go/"
GOBIN="${GOROOT}/bin"
export "PATH=$PATH:${GOBIN}"