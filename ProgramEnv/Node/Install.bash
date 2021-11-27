#!/usr/bin/env bash
# author: payne
# email: wuzhipeng1289690157@gmail.com
# Set up Node development environment

VERSION=14
# Download and install dependencies
curl --silent --location https://rpm.nodesource.com/setup_${VERSION}.x | sudo bash -
# install nodejs
sudo yum install -y nodejs
# check it version status
node -v
