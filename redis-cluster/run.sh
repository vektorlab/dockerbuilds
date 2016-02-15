#!/bin/bash

INITIAL_CLUSTER_MEMBERS=3
REDIS_CONFIG=$1

function output() {
  echo -ne '[\033[34mredis-cluster\033[m] '
  echo $@
}

function waitForMembers() {
  etcdctl --peers $ETCD_HOST ls /redis-cluster/ 
}

ETCD_HOST=

[ ! -f $REDIS_CONFIG ] && {
  echo "unable to read config file"
	exit 1
}

redis-server $REDIS_CONFIG &

wait
