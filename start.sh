#!/bin/sh

# Remplace le placeholder dans le fichier de configuration avec la variable d'environnement LISTEN_PORT
sed -i "s/LISTEN_PORT/${LISTEN_PORT}/g" /etc/nginx/nginx.conf

# Démarre Nginx
nginx -g 'daemon off;'
