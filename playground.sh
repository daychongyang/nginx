#!/bin/bash
readonly TARGET="playground"

if [ "$(docker ps -q -f name=$TARGET)" ]; then
    docker exec -it $TARGET bash
elif [ "$(docker ps -a -q -f name=$TARGET)" ]; then
    docker start -a $TARGET
else
    docker pull centos:7
    docker run -d --name $TARGET -it centos:7 bash
fi
