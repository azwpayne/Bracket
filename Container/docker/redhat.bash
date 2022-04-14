#!/usr/bin/env bash
# @author: payne
# @email: wuzhipeng1289690157@gmail.com
# docs: https://docs.docker.com/engine/install/centos/
# Install docker for redhat

# check Network
ping -c 4 www.baidu.com &&
  [ $? -ne 0 ] && echo "ERROR: The network is not smooth" && exit 1

# Uninstall old versions(Optional)
sudo yum remove docker \
  docker-client \
  docker-client-latest \
  docker-common \
  docker-latest \
  docker-latest-logrotate \
  docker-logrotate \
  docker-engine

## Set up the repository
sudo yum install -y yum-utils

sudo yum-config-manager \
  --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo

## Install Docker Engine
sudo yum makecache fast && sudo yum install -y docker-ce docker-ce-cli containerd.io

## add some params
mkdir -p /etc/docker
cat <<EOF >>/etc/docker/daemon.json
{
  "registry-mirrors": ["https://etdea28s.mirror.aliyuncs.com"]
}
EOF

## Set up docker auto start and reload the docker
mkdir -p /etc/systemd/system/docker.service.d &&
  sudo systemctl enable docker && sudo systemctl daemon-reload
## restart docker
systemctl restart dockers
