#!/bin/bash
set -e
echo "Installing E4D Build dependencies"
export DEBIAN_FRONTEND=noninteractive
apt-get update -y
apt-get install -y \
    git \
    gfortran \
    build-essential \
    expect-dev \
    python3 \
    python3-pip \
    unzip \


