#!/bin/sh

function output() {
  echo -ne '[\033[34metcd-wrapper\033[m] '
  echo $@
}
# Check for $CLIENT_URLS
if [ -zG ${CLIENT_URLS+x} ]; then
  CLIENT_URLS="http://0.0.0.0:4001,http://0.0.0.0:2379"
  output "Using default CLIENT_URLS ($CLIENT_URLS)"
else
  output "Using CLIENT_URLS: $CLIENT_URLS"
fi

# Check for $PEER_URLS
if [ -z ${PEER_URLS+x} ]; then
  PEER_URLS="http://0.0.0.0:7001,http://0.0.0.0:2380"
  output "Using default PEER_URLS ($PEER_URLS)"
else
  output "Using PEER_URLS: $PEER_URLS"
fi

output "starting etcd..."
/bin/etcd -data-dir=/data -listen-peer-urls=${PEER_URLS} -listen-client-urls=${CLIENT_URLS} $*
output "exited"
