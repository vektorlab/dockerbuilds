#!/bin/sh

[ ! -z "$ES_URL" ] && {
  echo "elasticsearch.url: \"http://${ES_URL}\"" >> /kibana/config/kibana.yml
}

cd /kibana 
exec ./bin/kibana
