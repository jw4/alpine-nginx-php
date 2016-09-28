#!/bin/bash

export HOST_USER=$(getent passwd 1000 | awk -F : '{print $1}')

addgroup nginx ${HOST_USER}

sed -i -e "s/user=weldon/user=${HOST_USER}/g" /conf/supervisord/*
