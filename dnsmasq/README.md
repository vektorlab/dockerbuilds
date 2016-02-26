# dnsmasq

Alpine-based dnsmasq image

NOTE: running dnsmasq requires the NET_ADMIN capacity. e.g.:
```
docker run -ti -P --cap-add=NET_ADMIN vektorlab/dnsmasq:latest
```
