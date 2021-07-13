#!/usr/bin/bash
# Prepare configuration file
Redis_Port=(3220 3221 3222 3223 3224 3225 3226 3227 3228)

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
