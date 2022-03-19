FROM ubuntu:20.04

LABEL maintainer="Bilal Khalid"

ARG NODE_VERSION=16

WORKDIR /var/www/html

ENV DEBIAN_FRONTEND noninteractive
ENV TZ=UTC

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update \
    && apt-get install -y gnupg gosu ca-certificates apt-transport-https \
        software-properties-common lsb-release libcap2-bin libpng-dev \
        python2 sqlite3 wget curl zip unzip git supervisor \
    && apt-key adv --keyserver hkps://keyserver.ubuntu.com --recv-keys 14AA40EC0831756756D7F66C4F4EA0AAE5267A6C \
    && echo "deb https://ppa.launchpadcontent.net/ondrej/php/ubuntu focal main" > /etc/apt/sources.list.d/ppa_ondrej_php.list \
    && apt-get update \
    && apt-get install -y php8.1-fpm php8.1-cli php8.1-dev \
        php8.1-sqlite3 php8.1-gd php8.1-curl php8.1-imap \
        php8.1-mysql php8.1-mbstring php8.1-xml php8.1-zip \
        php8.1-bcmath php8.1-soap php8.1-intl php8.1-readline \
        php8.1-ldap php8.1-msgpack php8.1-igbinary php8.1-redis \
        php8.1-swoole php8.1-memcached php8.1-pcov \
    && php -r "readfile('https://getcomposer.org/installer');" | php -- --install-dir=/usr/bin/ --filename=composer \
    && curl -sL https://deb.nodesource.com/setup_$NODE_VERSION.x | bash - \
    && apt-get install -y nodejs \
    && npm install -g npm \
    && apt-get install -y mysql-client \
    && apt-get -y autoremove \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
