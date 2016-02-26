FROM vektorlab/base:latest

RUN apk add --no-cache nginx && \
    mkdir -p /var/cache/nginx /var/log/nginx && \
    chown -Rf nginx. /var/cache/nginx /var/log/nginx

COPY nginx.conf /etc/nginx/nginx.conf

CMD [ "nginx" ]
