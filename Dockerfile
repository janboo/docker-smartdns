FROM alpine:3.12

LABEL maintainer="jxinran <janboo.one@gmail.com>"

ADD dl.sh /dl.sh
ADD start.sh /start.sh
ADD config.conf /config.conf

RUN set -ex \
	&& apk add --no-cache --virtual .wget-deps \
        wget=1.20.3-r1 \
    && sh dl.sh \
	&& rm -f dl.sh \
    && apk del .wget-deps \
    && apk add --no-cache ca-certificates

WORKDIR /

VOLUME ["/smartdns"]

EXPOSE 53

CMD ["/start.sh"]
