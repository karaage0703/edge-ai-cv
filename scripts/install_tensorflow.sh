#!/bin/bash
# Raspberry Pi OS(64-bit) A port of Debian Bullseye with the Raspberry Pi Desktop 2023-02-21
# Linux raspberrypi 5.15.84-v8+ #1613 SMP PREEMPT Thu Jan 5 12:03:08 GMT 2023 aarch64 GNU/Linux
# Reference:
# https://elchika.com/article/10487527-afbe-48c7-afc6-6c088a462a3c/
# https://github.com/PINTO0309/Tensorflow-bin

REQUIRED_OS_VERSION='11'
REQUIRED_ARCH="aarch64"


# install apt-get package
apt_get_install(){
    sudo apt-get update
    sudo apt-get install -y libhdf5-dev libc-ares-dev libeigen3-dev gcc gfortran libgfortran5 libatlas3-base libatlas-base-dev libopenblas-dev libopenblas-base libblas-dev liblapack-dev cython3 libatlas-base-dev openmpi-bin libopenmpi-dev python3-dev python-is-python3
}

# install pip package
pip_install(){
    sudo pip3 install -U pip
    sudo pip3 install keras_applications==1.0.8 --no-deps
    sudo pip3 install keras_preprocessing==1.1.2 --no-deps
    sudo pip3 install numpy==1.24.2
    sudo pip3 install h5py==3.6.0
    sudo pip3 install pybind11==2.9.2
    sudo pip3 install -U --user six wheel mock
    sudo pip3 uninstall tensorflow
}

# install tensorflow
tensorflow_install(){
    TFVER=2.10.0
    PYVER=39
    ARCH=`python -c 'import platform; print(platform.machine())'`
    echo CPU ARCH: ${ARCH}

    sudo -H pip3 install --no-cache-dir https://github.com/PINTO0309/Tensorflow-bin/releases/download/v${TFVER}/tensorflow-${TFVER}-cp${PYVER}-none-linux_${ARCH}.whl
}

# Check OS version
OS_VERSION=$(cat /etc/os-release | grep -w "VERSION_ID" | cut -d '=' -f2 | tr -d '"')

# Check architecture
ARCH=$(uname -m)

if [ "$OS_VERSION" == "$REQUIRED_OS_VERSION" ] && [ "$ARCH" == "$REQUIRED_ARCH" ]; then
    echo "Running on Raspberry Pi OS $REQUIRED_OS_VERSION and $REQUIRED_ARCH architecture."

    START_TIME=`date +%s`

    apt_get_install
    pip_install
    tensorflow_install

    END_TIME=`date +%s`

    SS=`expr ${END_TIME} - ${START_TIME}`
    HH=`expr ${SS} / 3600`
    SS=`expr ${SS} % 3600`
    MM=`expr ${SS} / 60`
    SS=`expr ${SS} % 60`

    echo "Total Time(Setup TensorFlow): ${HH}:${MM}:${SS} (h:m:s)"
else
    echo "Error: This script requires Raspberry Pi OS $REQUIRED_OS_VERSION and $REQUIRED_ARCH architecture."
    exit 1
fi

