#!/usr/bin/bash
# Install single redis
#Redis_VERSION=6.2.5
#curl -fsSL -o /tmp/redis_${Redis_VERSION}.tar.gz https://download.redis.io/releases/redis-${Redis_VERSION}.tar.gz &&
#  tar -zxf /tmp/redis_${Redis_VERSION}.tar.gz -C /opt &&
#  rm /tmp/redis_${Redis_VERSION}.tar.gz &&
#  ln -s /opt/redis_${Redis_VERSION} /opt/redis

## link and Configure environment variables of redis
ln -s /opt/redis/redis-${Redis_Version}/ /usr/local/redis && echo "export PATH=/usr/local/redis/src:\$PATH" >>/etc/profile

# rm Installation package
source /etc/profile
