FROM php:7.1.7-apache

MAINTAINER Harry Hsu <harry@acom-networks.com>

RUN apt-get update && apt-get install -y libmcrypt-dev \
    && docker-php-ext-install -j$(nproc) mcrypt mysqli

ENV MYSQL_ALLOW_EMPTY_PASSWORD=yes
ENV MYSQL_DATABASE=newbouncer

EXPOSE 80
