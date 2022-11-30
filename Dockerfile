FROM alpine

RUN apk update \
  && apk add nginx openrc \
  && adduser -D -g 'www' www \
  && mkdir /www \
  && chown -R www:www /var/lib/nginx \
  && chown -R www:www /www \
  && mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.orig

COPY nginx.conf /etc/nginx/nginx.conf
COPY index.html /www/index.html
COPY start_nginx.sh /start_nginx.sh

EXPOSE 80

RUN openrc \
  && touch /run/openrc/softlevel \
  && touch /var/log/nginx/error.log \
  && openrc \
  && apk add curl \
  && chmod +x /start_nginx.sh

CMD ["nginx", "-g", "daemon off;"]

