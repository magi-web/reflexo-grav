FROM php:7.3-fpm-alpine as grav_php
LABEL maintainer="Mathieu GIRARD <mgirard.dev@gmail.com>"

RUN rm -rf /var/cache/apk/* && \
    rm -rf /tmp/*

RUN apk update

RUN apk add bash

# Install Grav requirements
# Install dependencies
RUN \
    apk add --no-cache --virtual .persistent-deps \
        unzip \
        freetype-dev \
        libjpeg-turbo-dev \
        libpng-dev \
		libzip-dev \
        yaml-dev \
		zlib-dev \
	&& docker-php-ext-configure zip --with-libzip \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
	&& docker-php-ext-install \
        gd \
        opcache \
        zip

# Install custom entrypoint
COPY entrypoint.sh /usr/local/bin/docker-custom-entrypoint
RUN chmod 777 /usr/local/bin/docker-custom-entrypoint
CMD ["php-fpm"]
ENTRYPOINT ["docker-custom-entrypoint"]

# Set user to www-data
RUN chown www-data:www-data /var/www
USER www-data

# Define Grav version and expected SHA1 signature
#ENV GRAV_VERSION 1.6.16
#ENV GRAV_CHECKSUM

ARG GRAV_VERSION
ARG GRAV_CHECKSUM

# Install grav
WORKDIR /var/www
RUN curl -o grav-admin.zip -SL https://getgrav.org/download/core/grav-admin/${GRAV_VERSION} && \
    echo "Expected checksum : $GRAV_CHECKSUM" && \
	sha1sum grav-admin.zip && \
	echo "$GRAV_CHECKSUM  grav-admin.zip" | sha1sum -c - && \
    unzip grav-admin.zip && \
    mv /var/www/grav-admin/* /var/www/html* && \
    rm grav-admin.zip && \
	cp -R /var/www/html/* /var/www/app/

# Return to root user
USER root
