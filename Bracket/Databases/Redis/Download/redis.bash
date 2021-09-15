#!/usr/bin/bash

RedisVerison=6.2.5
# download Redis
wget "https://download.redis.io/releases/redis-${RedisVerison}.tar.gz"
## create folder and  unzip Redis.tar.gz file
mkdir -p /opt/redis/
tar xzf redis-${RedisVerison}.tar.gz -C /opt/redis/
## compile redis
cd /opt/redis/redis-${RedisVerison} && make
## link and Configure environment variables of redis
ln -s /opt/redis/redis-$RedisVerison/ /usr/local/redis
echo "export PATH=/usr/local/redis/src:\$PATH" >> /etc/profile
source /etc/profile
rm -rf redis-${RedisVerison}.tar.gz
