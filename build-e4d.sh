#!/bin/bash
set -e
if [ -z "$2" ] || [ -z "$1" ]
then
  echo "You must specify the e4d repo as the first argument, and the version "\
       "(git ref) as the second argument"
  exit 1
fi
E4D_REPO=$1
E4D_VERSION=$2
#E4D_VERSION=7e4446bd #Upstream version that worked in sep 2020
if [ -z "$PETSC_DIR" ]
then
  export PETSC_DIR=`realpath ./petsc`
fi
if [ -z "$PETSC_ARCH" ]
then
  export PETSC_ARCH=arch-linux-c-opt
fi
git clone $E4D_REPO
E4D_ROOT=`realpath ./E4D`
cd $E4D_ROOT
git checkout $E4D_VERSION
cd src

# Build e4d
make PETSC_DIR=$PETSC_DIR PETSC_ARCH=$PETSC_ARCH -j$(nproc)
if [ ! -d "../bin" ]
then
  mkdir $E4D_ROOT/bin
fi
cp e4d $E4D_ROOT/bin

# Build triangle
cd $E4D_ROOT/third_party/triangle
unzip -o triangle.zip
make triangle
cp triangle $E4D_ROOT/bin

# Build tetgen
cd $E4D_ROOT/third_party/tetgen1.5.0/
make clean || true
make
cp ./tetgen $E4D_ROOT/bin

# Build px
cd $E4D_ROOT/utilities/python/px
pip3 install pyinstaller
pip3 install mpi4py
pip3 install h5py
pyinstaller --hidden-import mpi4py.MPI -D -F -n px -c "px.py"
cp ./dist/px $E4D_ROOT/bin
