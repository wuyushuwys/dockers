#!/bin/bash

# close container by name
echo Enter Container name: 
read NAME
echo Your Container name is: $NAME
docker rm -f $NAME
echo Close container: $NAME
