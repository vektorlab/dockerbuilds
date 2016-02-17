FROM vektorlab/python2:latest

ENV DOCKER_HOST unix:///var/run/docker.sock
ENV DOCKERGEN_VERSION 0.6.0

COPY requirements.txt /requirements.txt
RUN apk add --no-cache --update libffi-dev openssl-dev && \
    pip install -r /requirements.txt

RUN cd /tmp/ && \
    wget -q https://github.com/jwilder/docker-gen/releases/download/${DOCKERGEN_VERSION}/docker-gen-linux-amd64-${DOCKERGEN_VERSION}.tar.gz && \
    tar xvzf docker-gen-linux-amd64-${DOCKERGEN_VERSION}.tar.gz -C /usr/local/bin && \
    rm -f docker-gen-linux-amd64-${DOCKERGEN_VERSION}.tar.gz

COPY etcd.tmpl /etcd.tmpl

CMD docker-gen -interval 10 -watch -notify-output -notify "python /tmp/register.py" /etcd.tmpl /tmp/register.py
