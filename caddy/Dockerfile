FROM golang:alpine as builder

ARG VERSION="0.10.10"
ENV VERSION=${VERSION}

ARG plugins
ENV PLUGINS=${PLUGINS}

COPY builder.sh /usr/bin/builder.sh

RUN apk add --no-cache git \
  && /bin/sh /usr/bin/builder.sh


FROM alpine

LABEL maintainer "Emmanuel Gautier <docker@emmanuelgautier.fr>"

COPY --from=builder /install/caddy /usr/bin/caddy
COPY Caddyfile /etc/Caddyfile

VOLUME /root/.caddy

EXPOSE 80 443 2015

ENTRYPOINT ["/usr/bin/caddy"]
CMD ["--conf", "/etc/Caddyfile", "--log", "stdout"]
