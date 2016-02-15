FROM quay.io/vektorlab/python:2

COPY requirements.txt /requirements.txt
RUN pip install -r /requirements.txt

COPY run.sh /run.sh

VOLUME /mnt
EXPOSE 3141

CMD /bin/bash /run.sh
