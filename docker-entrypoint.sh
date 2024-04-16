#!/usr/bin/env bash
set -e

if [[ `find /usr/src/typecho | wc -l` != 1 ]]; then
    mv /usr/src/typecho/* /var/www/html
    chown www-data:www-data -R /var/www/html
fi

exec "$@"
