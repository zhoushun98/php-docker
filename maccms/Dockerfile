FROM php:7.4-apache

RUN set -eu; \
    a2enmod rewrite; \
    apt-get update && apt-get install -y \
    libfreetype-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    libzip-dev \
    zip \
    unzip \
  && docker-php-ext-configure gd --with-freetype --with-jpeg \
  && docker-php-ext-install -j$(nproc) \
      gd \
      zip \
      pdo_mysql \
  ; \
  rm -rf /var/lib/apt/lists/*

RUN curl -fsSLOJ https://github.com/magicblack/maccms10/archive/refs/tags/V2024.1000.4010.tar.gz; \
    tar zxf maccms10-2024.1000.4010.tar.gz; \
    mv maccms10-2024.1000.4010 /usr/src/maccms; \
    rm -rf maccms10-2024.1000.4010.tar.gz; \
    curl -fsSL https://raw.githubusercontent.com/zhoushun98/php-docker/main/maccms/DYXS2.zip -o /usr/src/maccms/template/DYXS2.zip; \
    cd /usr/src/maccms/template/ && unzip DYXS2.zip && rm -rf DYXS2.zip

WORKDIR /var/www/html
VOLUME /var/www/html

COPY docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["apache2-foreground"]
