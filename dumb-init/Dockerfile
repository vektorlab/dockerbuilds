FROM vektorlab/base:latest

ENV DUMB_INIT_VERSION 1.0.0

#build dumb-init
RUN apk add --no-cache wget tar ca-certificates gcc musl musl-dev make && \
    cd /tmp; wget https://github.com/Yelp/dumb-init/archive/v${DUMB_INIT_VERSION}.tar.gz && \
    tar zxf v${DUMB_INIT_VERSION}.tar.gz && \
    cd dumb-init-${DUMB_INIT_VERSION} && \
    make && mv -v dumb-init /bin/ && \
    apk del musl-dev gcc make
