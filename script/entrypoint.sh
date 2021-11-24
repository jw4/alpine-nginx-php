#!/usr/bin/env bash

set -eu -o pipefail

SCRIPTDIR="$(cd "$(dirname "$0")"; pwd -P)"
cd "${SCRIPTDIR}"

./init_sshd.sh
./update_supervisord.sh

case $1 in
  serve)
    supervisord --nodaemon --configuration="/conf/supervisord.conf"
    ;;
esac
