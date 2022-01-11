#!/usr/bin/env sh
sudo apt -y update &&
  apt -y upgrade &&
  apt -y full-upgrade &&
  apt -y autoclean &&
  apt -y autoremove

# Install dependencies
sudo apt install -y apt-transport-https ca-certificates \
  curl gnupg lsb-release wget make gcc automake \
  autoconf libtool tree iftop nethogs jnettop ntp ntpdate \
  build-essential libssl-dev zliblg-dev libbz2-dev \
  libreadline-dev libsqlite3-dev llvm libncurses5-dev \
  libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev \
  python-openssl g++ libgcc-9-dev gcc-9-base mitmproxy
# Install miniconda
wget -c https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh &&
  sh Miniconda3-latest-Linux-x86_64.sh
#sudo apt-get install -y kali-desktop-gnome
#apt-get install fcitx
#apt-get install fcitx-googlepinyin
#sudo apt-get install linux-header- $(uname -r)
#sudo reboot
