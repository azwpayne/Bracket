#!/bin/bash


# docs:https://docs.docker.com/engine/install/centos/

# yum update or upgrade
yum -y update && yum -y upgrade
# install basic dependencies
echo "Start install basic dependencies"
sudo yum -y install gcc automake autoconf libtool make gcc-c++ yum-utils iftop nethogs ntp ntpdate
## Install Docker
### Uninstall old versions(Optional)
sudo yum remove docker \
  docker-client \
  docker-client-latest \
  docker-common \
  docker-latest \
  docker-latest-logrotate \
  docker-logrotate \
  docker-engine
### Set up the repository
sudo yum-config-manager \
  --add-repo \
  https://download.docker.com/linux/centos/docker-ce.repo

### Install Docker Engine
sudo yum install docker-ce docker-ce-cli containerd.io
### Set up docker auto start
sudo systemctl enable docker
### reload
sudo systemctl daemon-reload
