FROM php:8.0-fpm-alpine

ADD ./php/www.conf /usr/local/etc/php-fpm.d/

RUN addgroup -g 1000 laravel && adduser -G laravel -g laravel -s /bin/sh -D laravel

RUN mkdir -p /var/www/html

RUN chown laravel:laravel /var/www/html

WORKDIR /var/www/html

RUN docker-php-ext-install pdo pdo_mysql

#add xdebug
COPY ./php/xdebug.ini $PHP_INI_DIR/conf.d/

RUN apk add --no-cache $PHPIZE_DEPS \
	&& pecl install xdebug
	&& docker-php-ext-enable xdebug
