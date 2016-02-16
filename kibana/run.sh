#!/bin/sh

[ ! -z "$ES_URL" ] && {
  echo "elasticsearch.url: \"http://${ES_URL}:9200\"" >> /kibana/config/kibana.yml
}

cd /kibana 
exec ./bin/kibana
