#!/bin/bash

# close container by name
echo Enter Container name: 
read NAME
echo Your Container name is: $NAME
docker container stop $NAME
echo Stop container: $NAME
