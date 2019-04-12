#!/bin/sh
set -e

if [ ! -f "${DEVPI_SERVERDIR}/.serverversion" ]; then
  devpi-server --init

  if [ -n "${DEVPI_PASSWORD}" ]; then
    devpi-server --restrict-modify root --start --host 127.0.0.1 --port 3142
    devpi-server --status
    devpi use http://127.0.0.1:3142
    devpi login root --password=''
    devpi user -m root password="${DEVPI_PASSWORD}"
    devpi index -y -c public pypi_whitelist='*'
    devpi-server --stop
  fi
fi

devpi-server \
  --logger-cfg=/logger_cfg.json \
  --mirror-cache-expiry=${DEVPI_MIRROR_CACHE_EXPIRY} \
  --host 0.0.0.0 \
  --port 3141
