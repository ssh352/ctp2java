#!/bin/bash

set -e
BUILDDIR=build
rm -rf $BUILDDIR
mkdir -p $BUILDDIR
pushd $BUILDDIR
cmake ..
make VERBOSE=1 -j1
popd
