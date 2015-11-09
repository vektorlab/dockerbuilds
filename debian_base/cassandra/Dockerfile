FROM docker.internal.vektor.nyc/core/etcd:latest

ENV CASSANDRA_VERSION 2.1.5
ENV CASSANDRA_URL http://archive.apache.org/dist/cassandra/$CASSANDRA_VERSION/apache-cassandra-$CASSANDRA_VERSION-bin.tar.gz
ENV PATH=$PATH:/app/bin

RUN wget -q $CASSANDRA_URL -O /tmp/apache-cassandra.tgz && \
		cd /tmp/ && tar xzf apache-cassandra.tgz && \
		mv apache-cassandra-* /app && \
		rm -f /tmp/*.tgz 
		
COPY run.sh /app/
COPY cassandra.yaml /app/config/

EXPOSE 9160 9042
CMD /bin/bash /app/run.sh
