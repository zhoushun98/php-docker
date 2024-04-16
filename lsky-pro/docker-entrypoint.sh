#!/usr/bin/env bash
set -e

if [[ ! -e /var/www/html/public/index.php ]]; then
    cp -a /usr/src/lsky-pro/* /var/www/html
    cp -a /usr/src/lsky-pro/.env.example /var/www/html
    chown www-data:www-data -R /var/www/html
    chmod 755 -R /var/www/html
fi

exec "$@"
