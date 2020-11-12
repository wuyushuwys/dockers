#!/bin/bash


# setup nvidia support for docker
sudo apt-get install -y nvidia-docker2
sudo systemctl daemon-reload
sudo systemctl restart docker
