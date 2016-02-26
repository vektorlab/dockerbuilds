FROM vektorlab/base:latest

RUN apk add --no-cache python python-dev && \
    wget "https://bootstrap.pypa.io/get-pip.py" -O /dev/stdout | python && \
    rm -f /var/cache/apk/*

CMD python
