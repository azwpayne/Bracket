#!/usr/bin/env bash
python3 -m pip install -U pip && python3 -m pip install pynvim && pip3 install neovim &&
  yum -y install neovim
curl -sLf https://spacevim.org/cn/install.sh | bash