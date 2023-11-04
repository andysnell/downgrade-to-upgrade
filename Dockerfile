# syntax=docker/dockerfile:1.4
ARG BASE_IMAGE=php:8.2-cli
FROM $BASE_IMAGE

ARG BASE_IMAGE=php:8.2-cli

WORKDIR /var/www

ENV PATH /var/www/vendor/bin:/home/dev/.composer/vendor/bin/:$PATH
ENV COMPOSER_HOME /home/dev/.composer

RUN groupadd --gid 1000 dev \
    && useradd --system --create-home --uid 1000 --gid 1000 --shell /bin/bash dev

RUN apt-get update \
    && apt-get install -y \
        apt-transport-https \
        autoconf \
        build-essential \
        curl \
        git \
        less \
        libgmp-dev \
        libicu-dev \
        libpng-dev \
        libsodium-dev \
        libxml2-dev \
        libzip-dev \
        pkg-config \
        unzip \
        zlib1g-dev \
    && apt-get clean

RUN docker-php-ext-install -j$(nproc) \
        bcmath \
        exif \
        gmp \
        intl \
        opcache \
        pcntl \
        zip \
    && pecl install redis  \
    && docker-php-ext-enable redis

RUN mkdir -p "/home/dev/.composer" \
  && mkdir -p "/home/dev/.bash_history" \
  && touch "/home/dev/.bash_history/.bash_history" \
  && chown -R "dev:dev" "/home/dev/" \
  && echo "PS1='[\[\e[32m\]$BASE_IMAGE\[\e[0m\]]:\[\e[96m\]\w \[\e[0m\]\\$ '" >> "/home/dev/.bashrc" \
  && echo "export PROMPT_COMMAND='history -a' && export HISTFILE=/home/dev/.bash_history/.bash_history" >> "/home/dev/.bashrc"

COPY --link --from=composer/composer:latest-bin /composer /usr/bin/composer
COPY --link ./settings.ini /usr/local/etc/php/conf.d/settings.ini

USER dev

RUN composer global config --no-plugins allow-plugins.dealerdirect/phpcodesniffer-composer-installer true \
    && composer global require  \
      dealerdirect/phpcodesniffer-composer-installer \
      php-parallel-lint/php-parallel-lint \
      phpstan/phpstan \
      psy/psysh \
      rector/rector \
      slevomat/coding-standard \
      squizlabs/php_codesniffer \
      icanhazstring/composer-unused \
      maglnet/composer-require-checker
