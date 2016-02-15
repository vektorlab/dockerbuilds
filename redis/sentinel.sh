#!/bin/bash

etcd_url="http://services.i.cluster1.com:4001/v2/keys/redis"

# randomly delay this script startup so multiple instances don't all run at the same time
sleep $(shuf -i 1-30 -n 1)

# discover the current master
master_redis=$(curl -sSL $etcd_url |sed 's|,|\n|g' |grep value |sed 's|"value":"\(.*\)"|\1|')

# if no master is set, claim the master spot
if [ -z "$master_redis" ]; then
    master_redis=${LOCAL_HOST}
    curl -sSL $etcd_url -XPUT -d value=${LOCAL_HOST} -d ttl=10
fi

echo "sentinel monitor cluster1 ${master_redis} 6379 2" >> /tmp/sentinel.conf
echo "sentinel down-after-milliseconds cluster1 10000" >> /tmp/sentinel.conf
echo "sentinel failover-timeout cluster1 20000" >> /tmp/sentinel.conf
echo "sentinel parallel-syncs cluster1 1" >> /tmp/sentinel.conf

if [ ${LOCAL_HOST} != ${master_redis} ]; then
    /usr/local/bin/redis-server --slaveof ${master_redis} 6379 &
else
    /usr/local/bin/redis-server &
fi
/usr/local/bin/redis-server /tmp/sentinel.conf --sentinel $* &


# periodically report who's the current master
while [ true ]; do
    redis-cli info |grep role:master > /dev/null
    if [ $? -eq 0 ]; then
        curl -sSL $etcd_url -XPUT -d value=${LOCAL_HOST} -d ttl=10 > /dev/null
    fi
    sleep 2
done
