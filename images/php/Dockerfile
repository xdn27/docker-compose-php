FROM php:8.3-fpm

WORKDIR /var/www

RUN apt-get update && \
    apt-get install -y git libzip-dev zip libmcrypt-dev libicu-dev libpng-dev libmagickwand-dev libjpeg-dev libfreetype6-dev libjpeg62-turbo-dev libgd-dev libbz2-dev

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

#RUN groupadd -g 1001 developer
#RUN useradd -u 1001 -g developer developer
#RUN chown -R developer:developer /var/www
RUN chmod -R 777 /var/www
#COPY --chown=developer:developer . /var/www
#USER developer
