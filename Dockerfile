FROM debian:buster-slim As smartdns_builder

RUN apt update && \
    apt install -y git make gcc libssl-dev && \
    git clone https://github.com/pymumu/smartdns.git --depth 1 && \
    cd smartdns && \
    sh ./package/build-pkg.sh --platform linux --arch `dpkg --print-architecture` --static

FROM alpine:latest

LABEL maintainer="jxinran <janboo.one@gmail.com>"

ADD start.sh /start.sh
ADD config.conf /config.conf
COPY --from=smartdns_builder /smartdns/src/smartdns /bin/smartdns

WORKDIR /

VOLUME ["/smartdns"]

EXPOSE 53

CMD ["/start.sh"]
