#!/bin/bash

if [ "$(docker ps -q -f name=nginx)" ]; then
    docker rm -f nginx
fi

if [ ! -d "nginx" ]; then
    docker pull nginx
    docker run -d --name nginx nginx
    docker cp nginx:/etc/nginx nginx
    docker rm -f nginx
fi

docker run -d -p 80:80 -p 8080:8080 --name nginx -v $(pwd)/nginx:/etc/nginx -v $(pwd)/www:/www nginx