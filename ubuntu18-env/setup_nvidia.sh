#!/bin/bash


# setup nvidia support for docker
GPU_FLAG=$(nvidia-smi | wc -l)
CONTAINER_FLAG=$(which nvidia-container-runtime-hook | wc -l)
BOLD=`tput bold`
RED=`tput setaf 9`
GREEN=`tput setaf 10`
NC=`tput sgr0`

sudo apt-get install -y nvidia-docker2
sudo systemctl daemon-reload
sudo systemctl restart docker
if [ $GPU_FLAG -ne 0 ] && [ $CONTAINER_FLAG -eq 0 ]
then
    echo -e "${BOLD}${GREEN}Install Nvidia Container Runtime"
    curl -s -L https://nvidia.github.io/nvidia-container-runtime/gpgkey | sudo apt-key add -
    distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
    curl -s -L https://nvidia.github.io/nvidia-container-runtime/$distribution/nvidia-container-runtime.list | \
    sudo tee /etc/apt/sources.list.d/nvidia-container-runtime.list
    sudo apt-get update

    echo -e "${BOLD}${GREEN}Installation finish"
elif [ $CONTAINER_FLAG -gt 0 ]
then
    echo -e "${BOLD}${GREEN}Nvidia Container Runtime already installed!"
elif [ $GPU_FLAG -eq 0 ]
then
    echo "${BOLD}${RED}ERROR: No Nvidia GPU Driver detected!"
fi
