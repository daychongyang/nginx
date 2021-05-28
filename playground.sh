#!/bin/bash
readonly TARGET="playground"

if [ "$(docker ps -q -f name=$TARGET)" ]; then
    docker exec -it $TARGET bash
elif [ "$(docker ps -a -q -f name=$TARGET)" ]; then
    docker start -a $TARGET
else
    docker pull centos:8
    docker run -d --name $TARGET -v $(pwd)/nginx:/usr/local/nginx -p 10086:8080 -it centos:8 bash
fi
