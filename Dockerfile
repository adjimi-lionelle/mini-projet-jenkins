FROM nginx:alpine

LABEL maintainer="lionelleadjimi@gmail.com"

COPY app /usr/share/nginx/html

COPY config/nginx.conf /etc/nginx/nginx.conf

COPY config/start.sh /start.sh
RUN chmod +x /start.sh

ENTRYPOINT ["/start.sh"]

