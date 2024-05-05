FROM php:7.4-apache

RUN set -eu; \
    a2enmod rewrite; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
        libfreetype-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
        libzip-dev \
  && docker-php-ext-configure gd --with-freetype --with-jpeg \
  && docker-php-ext-install -j$(nproc) \
      gd \
      zip \
      pdo_mysql \
  ; \
  rm -rf /var/lib/apt/lists/*

ADD --chown=33:33 ./maccms10.tar.xz /usr/src/maccms

WORKDIR /var/www/html
VOLUME /var/www/html

COPY docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["apache2-foreground"]
