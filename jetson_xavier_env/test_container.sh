#!/bin/bash

# container test
xhost +local:root
docker run -it --rm --runtime nvidia --network host jetson-env:latest
xhost -
