FROM alpine:3.10 AS build

RUN mkdir -p /tmp && echo  $'\n\
    #!/bin/bash\n\
    set -x\n\
    python3 -m pip install --upgrade pip\n\
    PIP_ONLY_BINARY=cmake python3 -m pip install cmake || true\n\
    hash cmake 2>/dev/null || {\n\
        echo "Build CMake from source ..."\n\
        cd /tmp\n\
        git clone -b \"v3.25.1\" --single-branch --depth 1 https://github.com/Kitware/CMake.git CMake\n\
        cd CMake\n\
        ./bootstrap --prefix=/usr/local\n\
        make -j$(nproc)\n\
        make install\n\
        cd ..\n\
        rm -rf CMake\n\
    }\n\
    cmake --version\n'\
  > /tmp/install_cmake.sh

RUN apk add --no-cache --virtual .build-deps bash git make gcc g++ openssl-dev curl-dev python3 ninja patch && \
    bash /tmp/install_cmake.sh
