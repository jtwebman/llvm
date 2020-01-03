FROM alpine:latest as build-llvm

RUN apk add --update --no-cache --virtual .fetch-deps alpine-sdk git cmake python3 perl libedit-dev python3-dev swig go ninja

ENV LLVM_VERSION=9.0.1

RUN mkdir /usr/src
WORKDIR /usr/src

RUN git clone  https://github.com/llvm/llvm-project.git -b llvmorg-$LLVM_VERSION --depth 1
WORKDIR /usr/src/llvm-project 

RUN mkdir build
WORKDIR /usr/src/llvm-project/build

RUN  cmake -G "Ninja" \
  -DLLVM_ENABLE_PROJECTS="clang-tools-extra;clang;compiler-rt;debuginfo-tests;licclc;libcxx;libcxxabi;libunwind;lld;lldb;llgo;llvm;openmp;parallel-libs;polly;pstl;" \
  -DCMAKE_INSTALL_PREFIX=/usr/build \
  -DCMAKE_BUILD_TYPE=Release \
  ../llvm
RUN ninja
