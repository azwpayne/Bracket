PORT=3213

read -p "please input your token to gender passwd: " token
PASSWD=`echo ${token} | base64`


mkdir -p /opt/redis/single_replica_set && cd $_

redis-server --port ${PORT} --protected-mode yes --appendonly yes \
    --appendfilename appendonly-${PORT}.aof --dbfilename dump-${PORT}.rdb \
    --aof-use-rdb-preamble yes --daemonize yes --requirepass ${PASSWD}

echo "====================="
echo "passwd: ${PASSWD}"
echo "====================="