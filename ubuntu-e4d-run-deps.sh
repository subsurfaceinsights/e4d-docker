#!/bin/bash
set -e
apt-get update -y
apt-get install -y \
    libgfortran5 \
    openssh-client \
    libnuma1 \
    sudo

