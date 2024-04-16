FROM php:7.4-apache

ENV TZ=Asia/Shanghai LANG=en_US.utf8

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
    rm -rf /var/lib/apt/lists/*

RUN set -ex; \
    apt-get update; \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        tzdata \
        locales \
        unzip \
        zip \
    ; \
    \
    echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen; \
    locale-gen; \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime; \
    echo $TZ > /etc/timezone; \
    dpkg-reconfigure --frontend noninteractive tzdata; \
    curl -fsSL https://github.com/typecho/typecho/releases/latest/download/typecho.zip -o /tmp/typecho.zip; \
    mkdir -p /usr/src/typecho; \
    unzip /tmp/typecho.zip -d /usr/src/typecho; \
    chown -R www-data:www-data /usr/src/typecho; \
    rm -rf /var/lib/apt/lists/* /tmp/*

VOLUME /var/www/html

COPY docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["apache2-foreground"]
