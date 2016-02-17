FROM vektorlab/python2:latest

ENV DOCKERGEN_VERSION 0.6.0
RUN cd /tmp/ && \
    wget -q https://github.com/jwilder/docker-gen/releases/download/${DOCKERGEN_VERSION}/docker-gen-linux-amd64-${DOCKERGEN_VERSION}.tar.gz && \
    tar xvzf docker-gen-linux-amd64-${DOCKERGEN_VERSION}.tar.gz -C /usr/local/bin && \
    rm -f docker-gen-linux-amd64-${DOCKERGEN_VERSION}.tar.gz

ENV DOCKER_HOST unix:///var/run/docker.sock

ENTRYPOINT ["docker-gen"]
