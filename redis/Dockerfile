FROM vektorlab/base:latest

RUN apk add --update redis && \
    mkdir /data && chown redis:redis /data

VOLUME /data
WORKDIR /data

USER redis
EXPOSE 6379
CMD [ "redis-server" ]
