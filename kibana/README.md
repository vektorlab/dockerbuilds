# kibana

Alpine-based Kibana image

## Usage

```bash
docker run -d -e ES_HOST="10.0.0.2:9200" vektorlab/kibana:latest
```

Where ES_HOST is the hostname/IP and port of the Elastic instance you wish to connect to
