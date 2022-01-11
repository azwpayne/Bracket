#!/usr/bin/env bash
# @author: payne
# @email: wuzhipeng1289690157@gmail.com
# doc: https://docs.mongodb.com/manual/tutorial/install-mongodb-on-red-hat/
# Install Mongo for redhat

## 1.Configure the package management system
cat <<EOF | sudo tee -a /etc/yum.repos.d/mongodb-org-4.4.repo
[mongodb-org-4.4]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/releasever/mongodb-org/4.4/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-4.4.asc
EOF

## 2.Install the MongoDB packages
sudo yum install -y mongodb-org
sudo yum install -y \
  mongodb-org-5.0.1 mongodb-org-database-5.0.1 \
  mongodb-org-server-5.0.1 mongodb-org-shell-5.0.1 \
  mongodb-org-mongos-5.0.1 mongodb-org-tools-5.0.1
