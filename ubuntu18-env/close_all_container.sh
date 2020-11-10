#!/bin/bash


# clear all current container

NUM_CURRENT_CONTAINER=$(docker ps -a -q | wc -l)

if [ $NUM_CURRENT_CONTAINER -gt 0 ]
then
    docker rm -f $(docker ps -a -q)
    echo close $NUM_CURRENT_CONTAINER container\(s\)
elif [ $NUM_CURRENT_CONTAINER -eq 0 ]
then
    echo No container exits
fi
