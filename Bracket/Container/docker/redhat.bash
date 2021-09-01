#!/usr/bin/env bash
# docs:https://docs.docker.com/engine/install/centos/
# author: payne
# email: wuzhipeng1289690157@gmail.com
# Install docker

# check Network
ping -c 4 www.baidu.com && \
  [ $? -ne 0 ] && echo "ERROR: The network is not smooth" && exit 1;

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

read -p "Use aliyun mirror [Y/N]:" Signal
if [[ ${Signal} == "Y" ]]; then
  sudo yum-config-manager \
  --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
else
  sudo yum-config-manager \
  --add-repo https://download.docker.com/linux/centos/docker-ce.repo
fi

## Install Docker Engine
sudo yum makecache fast && sudo yum install -y docker-ce docker-ce-cli containerd.io

## add some params
cat > /etc/docker/daemon.json << EOF
{
"exec-opts": ["native.cgroupdriver=systemd"]
"log-driver": "json-file",
"log-opts": {
    "max-size": "100m"
  }
}
EOF

## Set up docker auto start and reload the docker
mkdir -p /etc/systemd/system/docker.service.d && \
    sudo systemctl enable docker && sudo systemctl daemon-reload
## restart docker
systemctl restart docker