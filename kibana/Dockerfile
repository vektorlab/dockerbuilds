FROM vektorlab/base:latest

ENV KIBANA_VERSION 4.4.1

RUN apk add --no-cache nodejs && \
    wget -q https://download.elastic.co/kibana/kibana/kibana-${KIBANA_VERSION}-linux-x64.tar.gz && \
    tar zxf kibana-${KIBANA_VERSION}-linux-x64.tar.gz && mv kibana-${KIBANA_VERSION}-linux-x64 /kibana && \
    rm /kibana/node/bin/node /kibana/node/bin/npm && \
    ln -s /usr/bin/node /kibana/node/bin/node && \
    ln -s /usr/bin/npm /kibana/node/bin/npm && \
    adduser -D kibana && chown -Rf kibana /kibana && \
    rm kibana-${KIBANA_VERSION}-linux-x64.tar.gz
  
COPY run.sh /run.sh

USER kibana 
EXPOSE 5601
CMD [ "/run.sh" ]
