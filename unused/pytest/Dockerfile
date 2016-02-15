FROM quay.io/vektorlab/python:2

COPY requirements.txt /requirements.txt

RUN apk add --update make flex gcc g++ libc-dev perl && \
    $PIP_INSTALL -r /requirements.txt && \
    wget http://www.dwheeler.com/sloccount/sloccount-2.26.tar.gz -qO - | tar zxvf - -C /tmp && \
    cd /tmp/sloccount-* && \
    make && make install

COPY unittestlib /usr/local/src/unittestlib
RUN cd /usr/local/src/unittestlib && \
    python setup.py install

COPY run_tests.sh /run_tests
CMD /bin/bash /run_tests
