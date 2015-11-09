FROM docker.internal.vektor.nyc/core/base:latest

ENV REDIS_VERSION 3.0.4
ENV REDIS_DOWNLOAD_URL http://download.redis.io/releases/redis-3.0.4.tar.gz
ENV REDIS_DOWNLOAD_SHA1 cccc58b2b8643930840870f17280fcae57ed7675

RUN groupadd redis -g 400 && \
    useradd  redis -g 400 -u 400 && \
    buildDeps='gcc libc6-dev make curl'; \
    set -x; \
    apt-get update -yqq && apt-get install -y $buildDeps --no-install-recommends \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir -p /usr/src/redis \
    && curl -sSL "$REDIS_DOWNLOAD_URL" -o redis.tar.gz \
    && echo "$REDIS_DOWNLOAD_SHA1 *redis.tar.gz" | sha1sum -c - \
    && tar -xzf redis.tar.gz -C /usr/src/redis --strip-components=1 \
    && rm redis.tar.gz \
    && make -C /usr/src/redis \
    && make -C /usr/src/redis install \
    && rm -r /usr/src/redis \
    && apt-get autoremove -y && apt-get clean \
    && mkdir /data && chown redis:redis /data && chmod a+w /data

VOLUME /data
WORKDIR /data

USER redis
EXPOSE 6379

CMD [ "redis-server" ]
