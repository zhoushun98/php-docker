#!/usr/bin/env bash
set -e

if [[ ! -e /var/www/html/index.php ]]; then
    cp -a /usr/src/typecho/* /var/www/html
    chown www-data:www-data -R /var/www/html
fi

exec "$@"
