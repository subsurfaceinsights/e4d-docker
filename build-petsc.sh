#!/bin/bash
set -e
if [ -z "$1" ]
then
  echo "You must specify PETSC version (git ref) to build"
  exit 1
fi
PETSC_VERSION=$1
git clone https://gitlab.com/petsc/petsc
pushd petsc
git checkout $PETSC_VERSION
#unbuffer -p python2 -u
./configure \
  --CFLAGS='-O3' \
  --CXXFLAGS='-O3' \
  --FFLAGS='-O3' \
  --with-debugging=no \
  --download-openmpi \
  --download-fblaslapack
export PETSC_DIR=`realpath ./`
export PETSC_ARCH=arch-linux-c-opt
cd $PETSC_DIR
make all -j$(nproc)
popd

