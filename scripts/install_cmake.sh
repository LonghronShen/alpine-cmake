#!/bin/bash

set -x

export CMAKE_VERSION="v3.25.1"

python3 -m pip install --upgrade pip

PIP_ONLY_BINARY=cmake python3 -m pip install cmake || true

hash cmake 2>/dev/null || {
    echo "Build CMake from source ..."

    cd /tmp
    git clone -b "$CMAKE_VERSION" --single-branch --depth 1 https://github.com/Kitware/CMake.git CMake

    cd CMake
    ./bootstrap --prefix=/usr/local
    make -j$(nproc)
    make install
    cd ..

    rm -rf CMake
}

cmake --version
