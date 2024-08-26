#!/bin/sh

if [ -z "$LISTEN_PORT" ]; then
  LISTEN_PORT=$PORT
fi
sed -i "s/LISTEN_PORT/${LISTEN_PORT}/g" /etc/nginx/nginx.conf
nginx -g 'daemon off;'
