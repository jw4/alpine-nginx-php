#!/usr/bin/env bash

set -eu -o pipefail

HOST_USER=$(getent passwd 1000 | awk -F : '{print $1}')
export HOST_USER

addgroup nginx "${HOST_USER}"

sed -i -e "s/user=weldon/user=${HOST_USER}/g" /conf/supervisord/*
