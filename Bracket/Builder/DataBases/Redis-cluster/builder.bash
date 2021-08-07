#!/usr/bin/bash
# Prepare configuration file
Redis_Port=(3220 3221 3222 3223 3224 3225 3226 3227 3228)

# Get the first network card address
if [[ $(uname -s) == "Darwin" ]]; then
  ipaddrs=$(ifconfig en0 | grep -E "inet 1.*? netmask" | awk '{print $2}')
elif [[ $(uname -s) == "Linux" ]]; then
  ipaddrs=$(ifconfig eth0 | awk 'NR==2 {print $2}')
else
  echo "windows?"
fi

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
cat <<EOF | tee -a ./redis_cluster_conf/startServer.bash
#!/bin/bash
Redis_Port=(3220 3221 3222 3223 3224 3225 3226 3227 3228)
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
#redis-cli --cluster create ${ipaddrs}:3220 \
#  ${ipaddrs}:3221 \
#  ${ipaddrs}:3222 \
#  ${ipaddrs}:3223 \
#  ${ipaddrs}:3224 \
#  ${ipaddrs}:3225 \
#  ${ipaddrs}:3226 \
#  ${ipaddrs}:3227 \
#  ${ipaddrs}:3228 -a 5by65aSn5peg5q+UcmVkaXM=
