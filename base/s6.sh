#!/bin/bash
S6_VERSION="3.1.5.0"

wget -nv -O  /tmp/s6-overlay-noarch.tar.xz "https://github.com/just-containers/s6-overlay/releases/download/v${S6_VERSION}/s6-overlay-noarch.tar.xz"
tar -C / -Jxpf /tmp/s6-overlay-noarch.tar.xz 

ARCH=$(uname -m)

if [ $ARCH == "armv7l" ]; then
    wget -nv -O /tmp/s6.tar.gz "https://github.com/just-containers/s6-overlay/releases/download/v${S6_VERSION}/s6-overlay-armhf.tar.xz"
elif [ $ARCH == "aarch64" ]; then
    wget -nv -O /tmp/s6.tar.gz "https://github.com/just-containers/s6-overlay/releases/download/v${S6_VERSION}/s6-overlay-aarch64.tar.xz"
elif [ $ARCH == "x86_64" ]; then
    wget -nv -O /tmp/s6.tar.xz "https://github.com/just-containers/s6-overlay/releases/download/v${S6_VERSION}/s6-overlay-x86_64.tar.xz"
else
    echo 'NOT SUPPORTED ARCH: $ARCH'; exit 1; 
fi
tar -C / -Jxpf /tmp/s6.tar.xz
rm /tmp/s6.tar.xz
rm /tmp/s6-overlay-noarch.tar.xz
