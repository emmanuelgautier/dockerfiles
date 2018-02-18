FROM golang:alpine as builder

LABEL maintainer "Emmanuel Gautier <docker@emmanuelgautier.fr>"

ARG VERSION="0.10.10"
ENV VERSION=${VERSION}

ARG PLUGINS
ENV PLUGINS=${PLUGINS}

COPY builder.sh /usr/bin/builder.sh

RUN apk add --no-cache git \
  && /bin/sh /usr/bin/builder.sh
