#!/usr/bin/env bash
# remove mariadb
yum -y remove mari*
rm -rf /var/lib/mysql/*
# install MySQL
yum install -y mysql-community-server
wget -c https://dev.mysql.com/get/mysql80-community-release-el7-3.noarch.rpm
rpm -ivh mysql80-community-release-el7-3.noarch.rpm
yum install -y mysql-community-server
