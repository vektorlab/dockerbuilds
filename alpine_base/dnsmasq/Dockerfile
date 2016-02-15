FROM vektorlab/base:latest

RUN apk --update --no-cache add dnsmasq
EXPOSE 53 53/udp
ENTRYPOINT ["dnsmasq", "-k", "--user=dnsmasq"]
