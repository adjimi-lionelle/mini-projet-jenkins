#!/bin/sh

if [ -z "$LISTEN_PORT" ]; then
  PORT=80
fi
sed -i "s/LISTEN_PORT/${PORT}/g" /etc/nginx/nginx.conf
nginx -g 'daemon off;'
