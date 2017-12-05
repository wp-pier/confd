FROM golang:1.9-alpine as build

RUN apk add --no-cache make git

ARG APP_DIR=$GOPATH/src/github.com/kelseyhightower/confd
ARG GIT_URL=github.com/kelseyhightower/confd
ARG APP_VERSION=v0.14.0

RUN go get $GIT_URL && \
  ln -s $APP_DIR /app

WORKDIR /app

RUN git checkout $APP_VERSION                             &&\
    VERSION=$(egrep -o '[0-9]+\.[0-9a-z.\-]+' version.go) &&\
    GIT_SHA=$(git rev-parse --short HEAD)                 &&\
    GOARCH=amd64                                          &&\
    CGO_ENABLED=0                                         &&\
    go build -ldflags="-s -w -X main.GitSHA=${GIT_SHA}" -o bin/confd

FROM alpine:3.6

LABEL name="wppier/confd"
LABEL version="latest"

COPY --from=build /app/bin/confd /usr/local/bin/confd
