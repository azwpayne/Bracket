#!/usr/bin/env bash
# remove mariadb
yum -y remove mariadb && rpm -qa | grep mariadb && rm -rf /var/lib/mysql/*

# Install MySQL
yum install -y mysql-community-server && wget -c https://dev.mysql.com/get/mysql80-community-release-el7-3.noarch.rpm &&
  rpm -ivh mysql80-community-release-el7-3.noarch.rpm && yum clean all && yum makecache && yum install -y mysql-community-server

# set up Auto-start when boot
systemctl enable mysqld.service && systemctl start mysqld.service

# check default password
grep /var/log/mysqld.log "password"
