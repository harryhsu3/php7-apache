FROM php:7.1.14-apache

MAINTAINER Harry Hsu <harry@acom-networks.com>

RUN apt-get update && apt-get install -y libmcrypt-dev wget openssl libssl-dev \
    && docker-php-ext-install -j$(nproc) mcrypt mysqli pdo pdo_mysql mbstring ftp \
    && wget http://xdebug.org/files/xdebug-2.6.0.tgz -O /tmp/xdebug-2.6.0.tgz \
    && cd /tmp \
    && tar -xvzf xdebug-2.6.0.tgz \
    && cd /tmp/xdebug-2.6.0 \
    && phpize \
    && ./configure \
    && make \
    && cp modules/xdebug.so /usr/local/lib/php/extensions/no-debug-non-zts-20160303 \
    && rm -rf /tmp/* \
    && apt-get clean

ADD php.ini /usr/local/etc/php/

EXPOSE 80
