#!/bin/bash
# helm Official website： https://helm.sh/zh/docs/intro/install/
# install pkg url： https://get.helm.sh/helm-v3.5.2-linux-amd64.tar.gz
# system message: Linux ecs-fe36 3.10.0-1160.6.1.el7.x86_64 #1 SMP Tue Nov 17 13:59:11 UTC 2020 x86_64 x86_64 x86_64 GNU/Linux
# helm version: 3.5.2
yum install -y wget
wget https://get.helm.sh/helm-v3.5.2-linux-amd64.tar.gz
tar -zxvf helm-v3.5.2-linux-amd64.tar.gz -C /usr/local/helm
mv linux-amd64/helm /usr/local/bin/helm
helm version