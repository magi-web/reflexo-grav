#!/bin/bash
set -euo pipefail

# Allow the Symfony application to write inside volumes
mkdir -p /var/www/html/var/ && chown -R www-data /var/www/html/var/

chown -R www-data /var/www/html

watch -n 5 -d 'rsync -avu --exclude ".idea" --exclude ".svn" --exclude "docker" --exclude "docs"  --exclude "vendor" --exclude "var" /var/www/app/ /var/www/html/' > /dev/null &

exec "$@"
