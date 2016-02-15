FROM vektorlab/glibc:latest

RUN apk add --no-cache --update curl bzip2 libbz2 libffi ncurses5-libs libgcrypt expat
#RUN apk add openblas openblas-dev --update-cache --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted

ENV PYPY_PORTABLE pypy-4.0.1-linux_x86_64-portable

RUN wget -q https://bitbucket.org/squeaky/portable-pypy/downloads/${PYPY_PORTABLE}.tar.bz2 && \
    tar xjf ${PYPY_PORTABLE}.tar.bz2 && \
    mv ${PYPY_PORTABLE} /usr/lib/pypy && \
    ln -s /usr/lib/pypy/bin/pypy /usr/lib/pypy/bin/python && \
    ln -s /usr/lib/pypy/bin/libpypy-c.so /usr/lib/libpypy-c.so && \
    ln -s -f /usr/lib/libgcrypt.so.20 /usr/lib/libcrypt.so.1 && \
    ln -s /usr/glibc/usr/lib/ld-linux-x86-64.so.2 /usr/lib/ld-linux-x86-64.so.2 && \
    rm -f ${PYPY_PORTABLE}.tar.bz2

ENV PATH ${PATH}:/usr/lib/pypy/bin/
RUN curl -s https://bootstrap.pypa.io/get-pip.py | pypy

#RUN ln -s -f /usr/lib/libncurses.so.5.9 /usr/lib/libtinfo.so.5 && \
#    ln -s -f /usr/lib/libbz2.so.1 /usr/lib/libbz2.so.1.0 && \
#    ln -s -f /usr/lib/libgcrypt.so.20 /usr/lib/libcrypt.so.1
#
#RUN ldd /usr/lib/pypy/bin/pypy

#RUN apk del gfortran build-base python-dev openblas-dev && \
#    rm -rf /root/.cache/pip/* && \
#    rm -rf /var/cache/apk/* && \
#    rm -rf /tmp/*
