#!/usr/bin/env bash
set -e

if [[ ! -e /var/www/html/index.php ]]; then
    cp -a /usr/src/maccms/* /var/www/html
    chown www-data:www-data -R /var/www/html
    chmod -R 755 /var/www/html
fi

exec "$@"
