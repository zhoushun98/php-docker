FROM php:7.4-apache

RUN set -eu; \
    a2enmod rewrite; \
    apt-get update && apt-get install -y \
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

RUN curl -fsSLOJ https://github.com/magicblack/maccms10/archive/refs/tags/V2024.1000.4000.tar.gz; \
    tar zxf maccms10-2024.1000.4000.tar.gz; \
    mv maccms10-2024.1000.4000 /usr/src/maccms; \
    rm -rf maccms10-2024.1000.4000.tar.gz

WORKDIR /var/www/html
VOLUME /var/www/html

COPY docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["apache2-foreground"]
