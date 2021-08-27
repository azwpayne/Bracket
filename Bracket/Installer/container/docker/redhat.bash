#!/usr/bin/env bash
# docs:https://docs.docker.com/engine/install/centos/
# author: payne
# email: wuzhipeng1289690157@gmail.com
# Install docker

## SHELL START

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
sudo yum-config-manager --add-repo \
  https://download.docker.com/linux/centos/docker-ce.repo

## Install Docker Engine
sudo yum install -y docker-ce docker-ce-cli containerd.io
## Set up docker auto start and reload the docker
sudo systemctl enable docker && sudo systemctl daemon-reload
## restart docker
systemctl restart docker

## SHEL END