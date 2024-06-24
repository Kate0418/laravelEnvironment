FROM php:fpm

ARG APP_NAME
WORKDIR /laravel
COPY --from=composer /usr/bin/composer /usr/bin/composer

ENV COMPOSER_ALLOW_SUPERUSER 1
ENV COMPOSER_HOME "/opt/composer"
ENV PATH "$PATH:/opt/composer/vendor/bin"

RUN apt-get update && \
    apt-get -y install git unzip libzip-dev && \
    docker-php-ext-install zip

RUN composer global require "laravel/installer"
RUN laravel new ${APP_NAME}
