FROM php:8.2.9-apache

# Install the PHP extensions we need
RUN set -ex; 
RUN apt-get update; \
  apt-get install -y \
  libpq-dev \
  libpcre3-dev \
  libjpeg-dev \
  libpng-dev \
  ; \
  rm -rf /var/lib/apt/lists/*; \
  \
  docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr; \
  docker-php-ext-install gd mysqli opcache
# Install oauth, apcu extenstion, apcu backwards compatibility extensions
RUN pecl install oauth \
  && docker-php-ext-enable oauth 
RUN pecl install apcu \
  && docker-php-ext-enable apcu
RUN docker-php-ext-install pgsql \
  && docker-php-ext-enable pgsql \
  && docker-php-ext-install pdo pdo_pgsql

COPY . /var/www/html
COPY  ./config.ini /etc/test-config/config.ini

EXPOSE 80