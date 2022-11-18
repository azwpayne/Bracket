#!/usr/bin/env bash

# check Network
ping -c 4 www.baidu.com &&
  [ $? -ne 0 ] &&
  echo "ERROR: The network is not smooth" &&
  exit 1

# apt initialization
sudo apt -y update &&
  sudo apt -y upgrade &&
  sudo apt -y full-upgrade &&
  sudo apt -y autoclean &&
  sudo apt -y autoremove

# Download the required basic package
sudo apt install -y \
  apt-transport-https ca-certificates curl gnupg lsb-release wget make build-essential \
  gcc automake autoconf libtool tree iftop nethogs ntp ntpdate g++ htop fd-find
