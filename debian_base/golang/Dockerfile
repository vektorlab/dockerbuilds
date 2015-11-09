FROM docker.internal.vektor.nyc/core/base:latest

# SCMs for "go get", gcc for cgo
RUN apt-get -yqq update && apt-get install -yqq \
		ca-certificates curl gcc libc6-dev make \
		bzr git mercurial \
		--no-install-recommends && \
	  rm -rf /var/lib/apt/lists/*

ENV GOLANG_VERSION 1.4.2
ENV GOPATH /go
ENV PATH /go/bin:$PATH

RUN mkdir -p /go/src && \
    curl -sSL https://golang.org/dl/go$GOLANG_VERSION.src.tar.gz | tar -v -C /usr/src -xz && \
    cd /usr/src/go/src && ./make.bash --no-clean 2>&1 && \
    cd / && rm -rf /usr/src/go*

WORKDIR /go
