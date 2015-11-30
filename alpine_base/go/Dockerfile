FROM quay.io/vektorlab/base:latest

RUN apk add --update curl git mercurial bzr go && rm -rf /var/cache/apk/*

ENV GOPATH=/go PATH=$PATH:$GOPATH/bin
WORKDIR /go
