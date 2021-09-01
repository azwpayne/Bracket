#!/usr/bin/env bash

# Create Redis cluster

## Variable
Redis_Port=(3220 3221 3222 3223 3224 3225 3226 3227 3228 3229)

## Get the first network card address
if [[ $(uname -s) == "Darwin" ]]; then
  LOCALHOST=$(ifconfig en0 | grep -E "inet 1.*? netmask" | awk '{print $2}')
elif [[ $(uname -s) == "Linux" ]]; then
  LOCALHOST=$(ifconfig eth0 | awk 'NR==2 {print $2}')
else
  echo "windows?"
  exit 1;
fi

## remote IP
IP=$(curl http://checkip.amazonaws.com/ && [ $? -ne 0 ] && echo "ERROR: The network is not smooth" && exit 1;)

# make file dir
mkdir redis_cluster_conf && cd redis_cluster_conf
for element in "${Redis_Port[@]}"; do
  mkdir "${element}"
  cd "${element}" || exit
  cp -p ../../redis.conf ./
  echo "port ${element}" >>redis.conf
  echo "pidfile /var/run/redis_${element}.pid" >>redis.conf
  echo "cluster-config-file nodes-${element}.conf" >>redis.conf
  cd ../
done
cd ../
cp redis_cluster_conf /opt/redis/
# start redis server
cat << EOF | tee -a ./redis_cluster_conf/startServer.bash
#!/bin/bash
Redis_Port=(3220 3221 3222 3223 3224 3225 3226 3227 3228 3229)

for element in "\${Redis_Port[@]}"; do
  cd "\${element}" || exit
  pwd
  echo "start server \${element}"
  redis-server redis.conf || exit
  echo "Startup complete \${element}"
  cd ..
done
EOF

#bash ./redis_cluster_conf/startServer.bash
# create cluster
#redis-cli  -a 5by65aSn5peg5q+UcmVkaXM= --cluster create \
#  $IP:3220 $IP:3221 $IP:3222 $IP:3223 $IP:3224 \
#  $IP:3225 $IP:3226 $IP:3227 $IP:3228 $IP:3229 \
#  --no-auth-warning --cluster-replicas 1