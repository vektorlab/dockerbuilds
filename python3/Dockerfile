FROM docker.internal.vektor.nyc/core/base:latest

RUN apt-get install -yqq --no-install-recommends \
    curl build-essential zlib1g-dev libbz2-dev liblzma-dev libssl-dev ca-certificates

# Install Python3
ENV PYTHON3_VERSION 3.4.3
RUN curl -ksSL -o python3.tgz https://www.python.org/ftp/python/$PYTHON3_VERSION/Python-$PYTHON3_VERSION.tgz \
    && mkdir /python3 \
    && tar -xzf python3.tgz -C /python3 --strip-components=1 \
    && rm python3.tgz \
    && cd /python3 \
    && ./configure --enable-shared \
    && make \
    && make install \
    && ldconfig \
    && cd / \
    && rm -rf /python3
