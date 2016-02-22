#!/bin/sh

[ ! -z "$ES_HOST" ] && {
  echo "elasticsearch.url: \"http://${ES_HOST}\"" >> /kibana/config/kibana.yml
}

cd /kibana 
exec ./bin/kibana
