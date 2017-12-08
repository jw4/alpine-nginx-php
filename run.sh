#!/usr/bin/env bash

CONTAINER_NAME="example"
IMAGE=docker.jw4.us/alpine-nginx-php
SCRIPTPATH="$( cd "$(dirname "$0")"; pwd -P)"

docker pull ${IMAGE}

docker stop ${CONTAINER_NAME} && \
  docker logs ${CONTAINER_NAME} &> $(TZ=UTC date +%Y-%m-%d-%H%M-${CONTAINER_NAME}.log) && \
  docker rm -v -f ${CONTAINER_NAME}

docker run -d \
  --name ${CONTAINER_NAME} \
  --restart=always \
  -p 2222:22 \
  -p 19988:80 \
  -v ${SCRIPTPATH}/web:/var/www \
  -v ${SCRIPTPATH}/nginx.conf.override:/etc/nginx/nginx.conf.local \
  ${IMAGE}
