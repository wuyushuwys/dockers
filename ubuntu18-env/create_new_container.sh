#!/bin/bash

# start a new container
# VIDEO_DEVICES=""
# for DEV in $(ls /dev/ | grep video)
# do
#     VIDEO_DEVICES="$VIDEO_DEVICES /dev/$DEV"
# done
echo Enter Container name: 
read NAME
echo Your Container name is: $NAME
xhost +local:root
docker run -it \
        --runtime=nvidia \
        --name $NAME \
        --mount type=bind,source="/home/$USER",target=/root/mount \
        --net=host \
        --ipc=host \
		--dns 8.8.8.8 \
        -e DISPLAY=unix$DISPLAY\
        --env="QT_X11_NO_MITSHM=1" \
        -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
        --privileged \
        -v /dev:/dev \
        wuyushu/ubuntu18-env:v2 bash
xhost -
