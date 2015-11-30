FROM quay.io/vektorlab/python:2

RUN apk add --update uwsgi uwsgi-python
    pip install uwsgi

COPY uwsgi.ini /uwsgi.ini

EXPOSE 8282
CMD /usr/sbin/uwsgi /uwsgi.ini
