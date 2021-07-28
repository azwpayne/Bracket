#!/usr/bin/env bash

# system init
sed -i 's/enforcing/disabled/' /etc/selinux/config

## update
yum -y update
## upgrade
yum -y upgrade
## install package
yum -y install gcc automake autoconf libtool make gcc-c++ yum-utils iftop nethogs ntp ntpdate bash-completion

## configure time synchronization
ntpdate time.windows.com
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
sudo yum install -y docker-ce docker-ce-cli containerd.io
### Set up docker auto start and reload the docker
sudo systemctl enable docker && sudo systemctl daemon-reload
### restart docker
systemctl restart docker

echo "source /usr/share/bash-completion/bash_completion" >> ~/.bashrc && source ~/.bashrc