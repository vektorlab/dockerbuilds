FROM quay.io/vektorlab/base:latest

ENV GEM_PATH /opt/synapse

RUN mkdir -p $GEM_PATH && \
    yum -y -q groupinstall 'Development Tools' && \
    yum -y -q install haproxy zlib-devel ruby-devel rubygems && \
    git clone https://github.com/bcicen/synapse.git $GEM_PATH &&  cd $GEM_PATH && \
    gem build synapse.gemspec && \
    gem install synapse-*.gem --install-dir $GEM_PATH --no-ri --no-rdoc && \
    yum -y -q groupremove 'Development Tools' && \
    yum clean all

COPY entrypoint.sh /entrypoint.sh
COPY synapse.conf.json /etc/synapse.conf.json

EXPOSE 7000-7100 8080 3212

CMD /bin/bash entrypoint.sh
