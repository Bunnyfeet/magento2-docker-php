FROM php:7.1-fpm

RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng-dev \
        curl libcurl4-openssl-dev \
        libxml2-dev \
        libicu-dev \
        libxslt-dev 
RUN docker-php-ext-install -j$(nproc) mcrypt \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-install bcmath \
    && docker-php-ext-install intl \
    && docker-php-ext-configure hash --with-mhash \
    && docker-php-ext-install soap \
    && docker-php-ext-install xsl \
    && docker-php-ext-install zip \
    && docker-php-ext-install pdo pdo_mysql

COPY install-composer.sh install-composer.sh

RUN apt-get install -y wget && bash install-composer.sh && mv composer.phar /usr/bin/composer

COPY src/CE-2.2.0 /var/www/html
COPY auth.json /var/www/html/auth.json

RUN cd /var/www/html && composer install

VOLUME ["/var/www/html"]