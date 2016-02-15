FROM docker.internal.vektor.nyc/core/base:latest

ENV VERSION v2.2.0 
ENV URL https://github.com/coreos/etcd/releases/download/$VERSION/etcd-$VERSION-linux-amd64.tar.gz

RUN curl -L $URL -o /tmp/etcd.tar.gz && \
    cd /tmp && tar zxf etcd.tar.gz && \
    mv -v etcd-*/etcd /usr/local/bin/ && \
    mv -v etcd-*/etcdctl /usr/local/bin/ && \
    rm -rf etcd*

VOLUME /data
ADD etcd.sh /etcd.sh
ADD etcd_monitor.sh /etcd_monitor.sh
RUN chmod a+x /*.sh
ENTRYPOINT ["/etcd.sh"]
