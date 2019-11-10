FROM php:7.1-cli

RUN apt-get update && \
    apt-get install -y --no-install-recommends git zip

RUN curl --silent --show-error https://getcomposer.org/installer | php

RUN mv composer.phar /usr/local/bin/composer

RUN apt-get install unzip

RUN docker-php-ext-install mysqli pdo_mysql

RUN apt-get install -y zlib1g-dev libzip-dev

RUN docker-php-ext-configure zip --with-libzip

RUN docker-php-ext-install zip

RUN pecl install apcu
RUN docker-php-ext-enable apcu