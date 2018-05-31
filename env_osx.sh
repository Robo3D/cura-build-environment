#!/bin/sh

export MACOSX_DEPLOYMENT_TARGET=10.7
export CC=/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/clang
export CXX=/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/clang++
export CPPFLAGS="-I/usr/local/opt/openssl/include -stdlib=libc++"
export CFLAGS="-stdlib=libc++"
export CXXFLAGS="-stdlib=libc++"
export LDFLAGS="-L/usr/local/opt/openssl/lib"
