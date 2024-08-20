#!/bin/sh

sed -i "s/LISTEN_PORT/${LISTEN_PORT}/g" /etc/nginx/nginx.conf
nginx -g 'daemon off;'
