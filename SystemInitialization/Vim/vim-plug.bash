#!/usr/bin/env bash
# Brief description of your script
# Copyright 2022 wu.zhipeng

echo "199.232.28.133 raw.githubusercontent.com" >>/etc/hosts
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
