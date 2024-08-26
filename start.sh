#!/bin/sh

sed -i "s/LISTEN_PORT/${PORT}/g" /etc/nginx/nginx.conf
nginx -g 'daemon off;'
