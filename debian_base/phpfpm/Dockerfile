FROM docker.internal.vektor.nyc/core/nginx:latest

RUN echo "deb http://cdn.content-network.net/mirror/dotdeb/ jessie all" >> /etc/apt/sources.list && \
    echo "deb-src http://packages.dotdeb.org jessie all" >> /etc/apt/sources.list && \
    wget http://www.dotdeb.org/dotdeb.gpg; apt-key add dotdeb.gpg

RUN apt-get -yqq update && \
    apt-get -yqq install openssl \
                         ca-certificates \
                         php5-cli \
                         php5-common \
                         php5-curl \
                         php5-gd \
                         php5-mysql \
                         php5-mcrypt \
                         php5-json \
                         php5-cgi \
                         php5-fpm \
                         php5-apcu

COPY php-fpm.conf /etc/php5/fpm/php-fpm.conf
COPY www.conf /etc/php5/fpm/pool.d/www.conf
