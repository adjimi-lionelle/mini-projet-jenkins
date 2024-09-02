#!/bin/sh

sed -i "s/PORT/${PORT}/g" /etc/nginx/nginx.conf
nginx -g 'daemon off;'