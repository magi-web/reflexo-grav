#!/bin/bash

mkdir -p /var/www/html && chown -R nginx /var/www/html
watch -n 2 -d 'rsync -avu /var/www/app/ /var/www/html/' > /dev/null &

exec "$@"
