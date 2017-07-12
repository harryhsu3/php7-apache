FROM php:7.1.7-apache

MAINTAINER Harry Hsu <harry@acom-networks.com>

RUN apt-get update && apt-get install -y libmcrypt-dev wget \
    && docker-php-ext-install -j$(nproc) mcrypt mysqli \
    && wget http://xdebug.org/files/xdebug-2.5.4.tgz -O /tmp/xdebug-2.5.4.tgz \
    && cd /tmp \
    && tar -xvzf xdebug-2.5.4.tgz \
    && cd /tmp/xdebug-2.5.4 \
    && phpize \
    && ./configure \
    && make \
    && cp modules/xdebug.so /usr/local/lib/php/extensions/no-debug-non-zts-20160303 \
    && echo 'zend_extension = /usr/local/lib/php/extensions/no-debug-non-zts-20160303/xdebug.so' > /usr/local/etc/php/php.ini \
    && rm -rf xdebug-2.5.4*

ENV MYSQL_ALLOW_EMPTY_PASSWORD=yes
ENV MYSQL_DATABASE=newbouncer

EXPOSE 80
