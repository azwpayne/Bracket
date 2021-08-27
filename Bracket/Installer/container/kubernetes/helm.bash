#!/usr/bin/env bash
# helm Official website： https://helm.sh/zh/docs/intro/install/
# install pkg url： https://get.helm.sh/helm-v3.5.2-linux-amd64.tar.gz
# system message: Linux ecs-fe36 3.10.0-1160.6.1.el7.x86_64 #1 SMP Tue Nov 17 13:59:11 UTC 2020 x86_64 x86_64 x86_64 GNU/Linux
# helm version: 3.5.2
version=3.5.2
pkg=helm-v${version}-linux-amd64.tar.gz

# download helm
yum install -y wget && \
    wget -c https://get.helm.sh/${pkg}

# install it
tar -zxvf ${pkg} && \
    mv linux-amd64/helm /usr/local/bin/helm

# check helm version
helm version