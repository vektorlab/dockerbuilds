# docker-register

A simple etcd service discovery container based on docker-gen. Containers with exactly one port published to the host will be registered in etcd at `/backends/<image_name>/<image_tag>/<image_id>`, e.g. `/backends/redis/latest/2f2ffba3ddf1`
