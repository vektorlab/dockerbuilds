FROM vektorlab/python2:latest

RUN apk add --no-cache gcc musl-dev uwsgi uwsgi-python && \
    pip install uwsgi && \
    apk del gcc musl-dev

COPY uwsgi.ini /uwsgi.ini

EXPOSE 8282
CMD /usr/sbin/uwsgi /uwsgi.ini
