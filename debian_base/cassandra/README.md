# cassandra

Image build of Cassandra server. Relies on using etcd to find an initial set of peers to bootstrap the cluster.

NOTE: To statically set a list of peers, start the container with ```-e SEEDS="seed1,seed2"```
