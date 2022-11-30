#!/bin/sh
echo hi >> /var/log/nginx/error.log
/usr/sbin/nginx -c /etc/nginx/nginx.conf

sleep 10
