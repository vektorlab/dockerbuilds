#!/bin/bash

# get the number of existing etcd servers reported by discovery service
bootstrap_servers=$(curl -sSL $ETCD_DISCOVERY | awk -F '"value":' '{print NF}')
echo "Found ${bootstrap_servers} bootstrapped servers"

# if already joined cluster, just start normally
if [ -d /data/member ]; then
    rm -rf /data/proxy
    echo "Rejoining existing cluster"
# enter bootstrap mode until the required minimum etcd servers is met
elif [ $bootstrap_servers -lt 4 ] || [ $healthy_servers -eq 0 ]; then
    if [ -z "${ETCD_DISCOVERY}" ]; then
        echo "error: ETCD_DISCOVERY is not set"
        exit 1
    else
        echo "entering bootstrap mode with discovery URL: ${ETCD_DISCOVERY}"
    fi

# join either as server or proxy depending on cluster size
else
    if [ $healthy_servers -lt 5 ]; then
        etcdctl member add ${ETCD_NAME} ${ETCD_INITIAL_ADVERTISE_PEER_URLS} || true
        export ETCD_INITIAL_CLUSTER_STATE=existing
        echo "Joining as new server to cluster"
    else
        export ETCD_PROXY=on
        echo "Joining as proxy"
    fi

    export ETCD_INITIAL_CLUSTER=$(etcdctl member list | sed 's/.*peerURLs=\(.*\)\( \|$\).*/\1/g' |awk -F: '{printf "%s=%s:%s:%s,", substr($2, 3), $1, $2, $3}' |sed 's|,$||')
    unset ETCD_DISCOVERY
    rm -rf /app/data/*
fi

# start the etcd daemon
/usr/local/bin/etcd
