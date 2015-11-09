FROM debian:jessie

#set apt to noninteractive mode
ENV DEBIAN_FRONTEND=noninteractive TERM=xterm

#disable apt cache inside containers
RUN echo "Acquire::http {No-Cache=True;};" > /etc/apt/apt.conf.d/no-cache

RUN apt-get update -qq && \
    apt-get -y -qq dist-upgrade && \
		apt-get -yqq install git-core \
                         wget \
                         curl \
                         vim \
                         locales \
                         apt-transport-https

#update, set and build locale
RUN update-locale && \
    echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen && \
    locale-gen && \
    echo ': ${LANG:=en_US.utf8}; export LANG' >> /etc/profile
