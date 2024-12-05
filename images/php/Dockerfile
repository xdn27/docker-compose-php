FROM php:8.3-fpm

WORKDIR /var/www

RUN apt-get update && \
    apt-get install -y git libzip-dev zip libmcrypt-dev libicu-dev libpng-dev libmagickwand-dev libjpeg-dev libfreetype6-dev libjpeg62-turbo-dev libgd-dev libbz2-dev passwd

# Install Composer.
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && ln -s $(composer config --global home) /root/composer
ENV PATH=$PATH:/root/composer/vendor/bin COMPOSER_ALLOW_SUPERUSER=1

RUN docker-php-ext-install mysqli pdo pdo_mysql && docker-php-ext-enable pdo_mysql
RUN docker-php-ext-configure intl && docker-php-ext-install intl
RUN docker-php-ext-install zip
RUN pecl install mcrypt && docker-php-ext-enable mcrypt
RUN docker-php-ext-configure gd --enable-gd --with-freetype --with-jpeg
RUN docker-php-ext-install gd
RUN docker-php-ext-install bz2
RUN pecl install xdebug && docker-php-ext-enable xdebug
# RUN pecl install imagick && docker-php-ext-enable imagick

# Install Postgre PDO
RUN apt-get install -y libpq-dev \
    && docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql \
    && docker-php-ext-install pdo pdo_pgsql pgsql

RUN useradd -u 1000 dev
RUN chown -R dev /var/www
RUN mkdir /home/dev/
RUN chown -R dev /home/dev/
