FROM alpine:3.10 AS build

RUN apk add --no-cache --virtual .build-deps \
  bash git make gcc g++ linux-headers binutils \
  python3 ninja patch openssl-dev curl-dev

COPY ./scripts/install_cmake.sh /tmp/install_cmake.sh

RUN bash /tmp/install_cmake.sh && rm /tmp/install_cmake.sh
