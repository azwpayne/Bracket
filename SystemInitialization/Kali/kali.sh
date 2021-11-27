#!/usr/bin/env sh
sudo apt -y update && apt -y upgrade && apt -y full-upgrade && apt -y autoclean && apt -y autoremove
sudo apt install -y apt-transport-https ca-certificates curl gnupg \
  lsb-release wget make gcc automake \
  autoconf libtool tree iftop nethogs ntp ntpdate
sudo apt-get install -y kali-desktop-gnome
apt-get install fcitx
apt-get install fcitx-googlepinyin
sudo apt-get install linux-header-$(uname -r)
sudo reboot