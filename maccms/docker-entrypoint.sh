#!/usr/bin/env bash
set -e

if [[ ! -e /var/www/html/index.php ]]; then
    cp -a /usr/src/maccms/* /var/www/html
    curl -fsSL https://raw.githubusercontent.com/magicblack/maccms10/master/%E8%AF%B4%E6%98%8E%E6%96%87%E6%A1%A3/%E4%BC%AA%E9%9D%99%E6%80%81%E8%A7%84%E5%88%99/.htaccess -o /var/www/html/.htaccess
    mv /var/www/html/admin.php /var/www/html/vip.php
    chown www-data:www-data -R /var/www/html
    chmod -R 755 /var/www/html
fi

exec "$@"
