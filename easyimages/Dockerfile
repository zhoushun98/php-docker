FROM php:7.4-apache

ENV TZ=Asia/Shanghai LANG=en_US.utf8

# config timezone and locale
RUN set -ex; \
  apt-get update; \
  DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    tzdata \
    locales \
  ; \
  \
  echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen; \
  locale-gen; \
  ln -snf /usr/share/zoneinfo/$TZ /etc/localtime; \
  echo $TZ > /etc/timezone; \
  dpkg-reconfigure --frontend noninteractive tzdata; \
  rm -rf /var/lib/apt/lists/*

# persistent dependencies
RUN set -eux; \
  apt-get update; \
  apt-get install -y --no-install-recommends \
# Ghostscript is required for rendering PDF previews
    ghostscript \
  ; \
  rm -rf /var/lib/apt/lists/*

# install the PHP extensions we need
RUN set -ex; \
  apt-get update; \
  apt-get install -y --no-install-recommends \
    libfreetype6-dev \
    libicu-dev \
    libjpeg-dev \
    libmagickwand-dev \
    libpng-dev \
    libwebp-dev \
    libzip-dev \
  ; \
  \
  docker-php-ext-configure gd \
    --with-freetype \
    --with-jpeg \
    --with-webp \
  ; \
  docker-php-ext-install -j "$(nproc)" \
    bcmath \
    exif \
    gd \
    intl \
    mysqli \
    zip \
    pdo_mysql \
  ; \
  pecl install imagick-3.7.0; \
  docker-php-ext-enable imagick; \
  rm -rf /var/lib/apt/lists/*

# set recommended PHP.ini settings
RUN set -eux; \
  a2enmod rewrite expires; \
  docker-php-ext-enable opcache; \
  { \
    echo 'opcache.memory_consumption=128'; \
    echo 'opcache.interned_strings_buffer=8'; \
    echo 'opcache.max_accelerated_files=4000'; \
    echo 'opcache.revalidate_freq=2'; \
  } > /usr/local/etc/php/conf.d/opcache-recommended.ini

# upload config
RUN set -eux; \
  { \
    echo 'post_max_size = 100M;';\
    echo 'upload_max_filesize = 100M;';\
    echo 'max_execution_time = 600S;';\
    echo 'memory_limit = 512M;'; \
  } > /usr/local/etc/php/conf.d/docker-php-upload.ini

RUN set -ex; \
  curl -fsSL https://github.com/icret/EasyImages2.0/archive/refs/tags/2.8.4.tar.gz -o /tmp/easyimages.tar.gz; \
  mkdir -p /usr/src/easyimages; \
  tar -zxf /tmp/easyimages.tar.gz -C /usr/src/easyimages --strip-components=1; \
  chown -R www-data:www-data /usr/src/easyimages; \
  rm -rf /var/lib/apt/lists/* /tmp/*

VOLUME /var/www/html

COPY docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["apache2-foreground"]
