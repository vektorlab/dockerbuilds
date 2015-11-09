#!/bin/bash

INITIAL_CLUSTER_SIZE=3

[ -z "$HOST_IP" ] && {
	echo "env var HOST_IP must be set"
	exit 1
}

[ -z "$ETCD_HOST" ] && {
	echo "env var ETCD_HOST must be set"
	exit 1
}

function getpeers() {
	SEEDS=""

	while [ $(etcdctl --peers $ETCD_HOST ls /backends/cassandra/latest/ | wc -l) -lt $INITIAL_CLUSTER_SIZE]; do
		echo "Waiting for initial cluster size of $INITIAL_CLUSTER_SIZE ... "
		sleep 2
	done

	for i in $(etcdctl --peers $ETCD_HOST ls /backends/cassandra/latest/); do 
		seed=$(etcdctl --peers $ETCD_HOST get $i; done | cut -f1 -d\: dt)
		SEEDS="${SEEDS},${seed}"
	done

}


ENV=/app/conf/cassandra-env.sh

# wait 10 seconds instead of 30
export JVM_OPTS="-Dcassandra.ring_delay_ms=10000"

# Fix JMX settings
sed -i -e 's/# JVM_OPTS="$JVM_OPTS -Djava.rmi.server.hostname=<public name>"/JVM_OPTS="$JVM_OPTS -Djava.rmi.server.hostname='$HOST_IP'"/g' $ENV

[ -z $SEEDS ] && getpeers

sed -i "s/_SEEDS_/${SEEDS}/g" /app/config/cassandra.yaml

/app/bin/cassandra -f
