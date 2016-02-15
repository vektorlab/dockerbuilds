FROM quay.io/vektorlab/python:2

RUN yum -y -q install ImageMagick

ENV NODEJS_VERSION 0.10.21

# Install Node.js
RUN \
  cd /tmp && \
#  wget http://nodejs.org/dist/node-latest.tar.gz && \
  wget http://nodejs.org/dist/v${NODEJS_VERSION}/node-v${NODEJS_VERSION}.tar.gz -O node-latest.tar.gz && \
  tar xvzf node-latest.tar.gz && \
  rm -f node-latest.tar.gz && \
  cd node-v* && \
  ./configure --prefix=/usr/ && \
  CXX="g++ -Wno-unused-local-typedefs" make && \
  CXX="g++ -Wno-unused-local-typedefs" make install && \
  cd /tmp && \
  rm -rf /tmp/* && \
  find /var/log/ -type f -delete && \
  echo '\n# Node.js\nexport PATH="node_modules/.bin:$PATH"' >> /root/.bash_profile

CMD [ "/usr/bin/node" ]
