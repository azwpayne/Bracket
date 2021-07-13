#!/usr/bin/bash

# download Redis
wget https://download.redis.io/releases/redis-6.2.4.tar.gz
# create folder and  unzip Redis.tar.gz file
mkdir -p /opt/redis/
tar xzf redis-6.2.4.tar.gz -C /opt/redis/
# compile redis
cd /opt/redis/redis-6.2.4
make
# link and Configure environment variables of redis
ln -s /opt/redis/redis-6.2.4/ /usr/local/redis
echo "export PATH=/usr/local/redis/src:$PATH" >>/etc/profile
source /ect/profile