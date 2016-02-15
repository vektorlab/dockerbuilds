#!/bin/bash

HOST_IP=$(curl http://169.254.169.254/latest/meta-data/local-ipv4)
sed -i "s/127.0.0.1/$HOST_IP/g" /etc/synapse.conf.json

/usr/sbin/haproxy -f /etc/haproxy/haproxy.cfg -p /run/haproxy.pid -D
${GEM_PATH}/bin/synapse -c /etc/synapse.conf.json
