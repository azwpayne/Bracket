#!/usr/bin/env bash

# check Network
ping -c 4 www.baidu.com &&
  [ $? -ne 0 ] && echo "ERROR: The network is not smooth" && exit 1

# apt initialization
sudo apt -y update && apt -y upgrade && apt -y full-upgrade && apt -y autoclean && apt -y autoremove
# Download the required basic package
sudo apt install -y apt-transport-https ca-certificates curl gnupg \
  lsb-release wget make gcc automake \
  autoconf libtool tree iftop nethogs ntp ntpdate
