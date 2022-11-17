#!/usr/bin/bash
# Install single redis
Redis_Version=6.2.5

# download Redis
wget "https://download.redis.io/releases/redis-${Redis_Version}.tar.gz"

## create folder and  unzip Redis.tar.gz file
mkdir -p /opt/redis/ && tar -xzf redis-${Redis_Version}.tar.gz -C /opt/redis/

## compile redis
cd /opt/redis/redis-${Redis_Version} && make

## link and Configure environment variables of redis
ln -s /opt/redis/redis-${Redis_Version}/ /usr/local/redis && echo "export PATH=/usr/local/redis/src:\$PATH" >>/etc/profile

# rm Installation package
source /etc/profile
