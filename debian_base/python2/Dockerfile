FROM docker.internal.vektor.nyc/core/base:latest

RUN apt-get install -yqq --no-install-recommends \
    build-essential python python-dev python-virtualenv

RUN wget https://bootstrap.pypa.io/get-pip.py -O /tmp/get-pip.py && \
		python /tmp/get-pip.py

CMD python
