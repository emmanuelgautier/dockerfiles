#!/bin/sh

VERSION=${VERSION:-"0.10.10"}
GOOS=${GOOS:-"linux"}
GOARCH=${GOARCH:-"amd64"}

# caddy
git clone https://github.com/mholt/caddy -b "v$VERSION" /go/src/github.com/mholt/caddy \
    && cd /go/src/github.com/mholt/caddy \
    && git checkout -b "v$VERSION"

# plugin helper
go get -v github.com/abiosoft/caddyplug/caddyplug
alias caddyplug="GOOS=$GOOS GOARCH=$GOARCH caddyplug"

# plugins
for plugin in $(echo $PLUGINS | tr "," " "); do \
    go get -v $(caddyplug package $plugin); \
    printf "package caddyhttp\nimport _ \"$(caddyplug package $plugin)\"" > \
        /go/src/github.com/mholt/caddy/caddyhttp/$plugin.go ; \
    done

# builder dependency
git clone https://github.com/caddyserver/builds /go/src/github.com/caddyserver/builds

# build
cd /go/src/github.com/mholt/caddy/caddy \
    && git checkout -f \
    && go run build.go -goos=$GOOS -goarch=$GOARCH -goarm=$GOARM \
    && mkdir -p /install \
    && mv caddy /install
