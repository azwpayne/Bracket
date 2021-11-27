#!/usr/bin/env bash
# @author: payne
# @email: wuzhipeng1289690157@gmail.com
# docs: https://docs.docker.com/engine/install/debian/
# Install Docker for debian

# install docker
##  Add Docker’s official GPG key:
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list >/dev/null

## download docker
sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io

## Perfect docker configure
### Set up docker auto start and reload the docker
sudo systemctl enable docker && sudo systemctl daemon-reload
### restart docker
systemctl restart docker
