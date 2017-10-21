FROM golang:1.9-alpine as build

LABEL name="wppier\confd"
LABEL version="0.0.1"

RUN apk add --no-cache make git

ARG ROOT_DIR=$GOPATH/src/github.com/kelseyhightower
ARG APP_DIR=$ROOT_DIR/confd
ARG GIT_URL=https://github.com/kelseyhightower/confd.git
ARG APP_VERSION=v0.14.0

RUN mkdir -p $ROOT_DIR && \
  git clone $GIT_URL $APP_DIR && \
  ln -s $APP_DIR /app

WORKDIR /app

RUN git checkout $APP_VERSION && \
  make build

FROM alpine:latest

COPY --from=build /app/bin/confd /usr/local/bin/confd

