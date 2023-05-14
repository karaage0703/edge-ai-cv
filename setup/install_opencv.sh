#!/bin/bash
# Raspberry Pi OS(64-bit) A port of Debian Bullseye with the Raspberry Pi Desktop 2023-02-21
# Linux raspberrypi 5.15.84-v8+ #1613 SMP PREEMPT Thu Jan 5 12:03:08 GMT 2023 aarch64 GNU/Linux
# Reference:
# https://elchika.com/article/10487527-afbe-48c7-afc6-6c088a462a3c/

REQUIRED_OS_VERSION='11'
REQUIRED_ARCH="aarch64"


# install apt-get package
apt_get_install(){
    sudo apt-get update
    sudo apt-get install -y libatlas-base-dev
}

# install OpenCV
install_opencv(){
    sudo pip3 install -U pip
    sudo pip3 --default-timeout=1000 install opencv-python==4.7.0.72
}


# Check OS version
OS_VERSION=$(cat /etc/os-release | grep -w "VERSION_ID" | cut -d '=' -f2 | tr -d '"')

# Check architecture
ARCH=$(uname -m)

if [ "$OS_VERSION" == "$REQUIRED_OS_VERSION" ] && [ "$ARCH" == "$REQUIRED_ARCH" ]; then
    echo "Running on Raspberry Pi OS $REQUIRED_OS_VERSION and $REQUIRED_ARCH architecture."

    START_TIME=`date +%s`

    apt_get_install
    install_opencv

    END_TIME=`date +%s`

    SS=`expr ${END_TIME} - ${START_TIME}`
    HH=`expr ${SS} / 3600`
    SS=`expr ${SS} % 3600`
    MM=`expr ${SS} / 60`
    SS=`expr ${SS} % 60`

    echo "Total Time(Setup OpenCV): ${HH}:${MM}:${SS} (h:m:s)"
else
    echo "Error: This script requires Raspberry Pi OS $REQUIRED_OS_VERSION and $REQUIRED_ARCH architecture."
    exit 1
fi

