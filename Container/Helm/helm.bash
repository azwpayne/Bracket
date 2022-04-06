#!/usr/bin/env bash
# @author: payne
# @email: wuzhipeng1289690157@gmail.com
# helm Official website： https://helm.sh/zh/docs/intro/install/
# install pkg url： https://get.helm.sh/helm-v3.5.2-linux-amd64.tar.gz
# system message: Linux ecs-fe36 3.10.0-1160.6.1.el7.x86_64 #1 SMP Tue Nov 17 13:59:11 UTC 2020 x86_64 x86_64 x86_64 GNU/Linux
# helm version: 3.5.2
version=3.5.2
pkg=helm-v${version}-linux-amd64.tar.gz
# download helm
curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash
# install it
tar -zxvf ${pkg} &&
  mv linux-amd64/helm /usr/local/bin/helm
# add Commonly used repo
helm repo add aliyuncs https://apphub.aliyuncs.com/
helm repo add bitnami https://charts.bitnami.com/bitnami/
helm repo add azure https://mirror.azure.cn/kubernetes/charts/
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo add stable https://charts.helm.sh/stable
# update repo
helm repo update
# check helm version
helm version
