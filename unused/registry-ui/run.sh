#!/bin/bash

[ -z $DOCKER_REGISTRY_HOST ] && {
    echo "env var DOCKER_REGISTRY_HOST must be provided"
    exit 1
}

echo "Starting registry frontend using $DOCKER_REGISTRY_HOST"
sed -i "s/DOCKER_REGISTRY_HOST/${DOCKER_REGISTRY_HOST}/g" /data/app/registry-host.json /data/nginx.conf

exec nginx -c /data/nginx.conf
