#!/bin/bash

# Attach Container name by name
echo Enter Your Container name:
read NAME
echo Your Container name is: $NAME

xhost +
docker start $NAME # restart it in the background
docker attach $NAME # reattach the terminal & stdin
xhost -
