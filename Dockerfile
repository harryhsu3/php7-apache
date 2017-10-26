FROM php:7.1.8-apache

MAINTAINER Harry Hsu <harry@acom-networks.com>

RUN apt-get update && apt-get install -y libmcrypt-dev wget openssl libssl-dev \
    && docker-php-ext-install -j$(nproc) mcrypt mysqli pdo pdo_mysql mbstring ftp \
    && wget http://xdebug.org/files/xdebug-2.5.4.tgz -O /tmp/xdebug-2.5.4.tgz \
    && cd /tmp \
    && tar -xvzf xdebug-2.5.4.tgz \
    && cd /tmp/xdebug-2.5.4 \
    && phpize \
    && ./configure \
    && make \
    && cp modules/xdebug.so /usr/local/lib/php/extensions/no-debug-non-zts-20160303 \
    && echo -e 'zend_extension = /usr/local/lib/php/extensions/no-debug-non-zts-20160303/xdebug.so\ndate.timezone=Asia/Taipei' > /usr/local/etc/php/php.ini \
    && rm -rf /tmp/* \
    && apt-get clean

EXPOSE 80
