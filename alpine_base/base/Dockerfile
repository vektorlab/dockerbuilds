FROM alpine:3.2

ENV DUMB_INIT_VERSION 1.0.0

#build dumb-init
RUN apk add --update wget tar ca-certificates gcc musl musl-dev make && \
    cd /tmp; wget https://github.com/Yelp/dumb-init/archive/v${DUMB_INIT_VERSION}.tar.gz && \
    tar zxf v${DUMB_INIT_VERSION}.tar.gz && \
    cd dumb-init-${DUMB_INIT_VERSION} && \
    make && mv -v dumb-init /bin/ && \
    apk del musl-dev gcc make

#install some common packages
RUN apk add --update wget curl bash tar ca-certificates
