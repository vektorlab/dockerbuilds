FROM quay.io/vektorlab/nodejs:latest

COPY nginx.repo /etc/yum.repos.d/nginx.repo
RUN yum -y -q install nginx

COPY src/ /data
RUN cd /data && \
    npm install && \
    node_modules/bower/bin/bower install --allow-root && \
    node_modules/grunt-cli/bin/grunt build --allow-root

#move installed files to webroot
RUN ln -s /data/dist/bower_components /data/bower_components/ 

ADD nginx.conf /data/nginx.conf
ADD run.sh /data/run.sh

EXPOSE 80

CMD /bin/bash /data/run.sh
