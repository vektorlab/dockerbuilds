FROM vektorlab/base:latest

ENV ALPINE_GLIBC_BASE_URL="https://circle-artifacts.com/gh/andyshinn/alpine-pkg-glibc/6/artifacts/0/home/ubuntu/alpine-pkg-glibc/packages/x86_64"
ENV ALPINE_GLIBC_VERSION="2.21-r2"

RUN apk add --no-cache --virtual=build-dependencies wget ca-certificates && \
    wget -q "$ALPINE_GLIBC_BASE_URL/glibc-${ALPINE_GLIBC_VERSION}.apk" && \
    wget -q "$ALPINE_GLIBC_BASE_URL/glibc-bin-${ALPINE_GLIBC_VERSION}.apk" && \
    apk add --no-cache --allow-untrusted *.apk && \
    /usr/glibc/usr/bin/ldconfig "/lib" "/usr/glibc/usr/lib" && \
    echo 'hosts: files mdns4_minimal [NOTFOUND=return] dns mdns4' >> /etc/nsswitch.conf && \
    apk del build-dependencies && rm *.apk
