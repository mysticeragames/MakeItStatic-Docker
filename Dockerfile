# Set base image
#ARG ALPINE_VERSION=3.21.1 ## Does NOT work with dependabot, so use hardcoded version
FROM alpine:3.21.1

# Set working directory
WORKDIR /var/www/html

# Add cms user with home dir (for git)
RUN addgroup -g 1000 cmsg && \
    adduser -D -G cmsg -u 1000 -h /home/cms -s /bin/sh cms

# Install packages
RUN apk add --no-cache \
    # bash \
    # curl \
    nginx \
    git \
    # npm \
    php84 \
    php84-ctype \
    # php84-curl \
    php84-dom \
    # php84-fileinfo \
    php84-fpm \
    # php84-gd \
    php84-iconv \
    # php84-intl \
    php84-mbstring \
    # php84-opcache \
    php84-openssl \
    php84-pecl-xdebug \
    php84-phar \
    php84-session \
    php84-simplexml \
    php84-tokenizer \
    php84-xml \
    # php84-xmlreader \
    php84-xmlwriter \
    supervisor

# Nginx
COPY config/nginx.conf /etc/nginx/nginx.conf
COPY config/conf.d /etc/nginx/conf.d/

# PHP
ENV PHP_INI_DIR=/etc/php84
COPY config/fpm-pool.conf ${PHP_INI_DIR}/php-fpm.d/www.conf
COPY config/php.ini ${PHP_INI_DIR}/conf.d/custom.ini
COPY config/99-xdebug.ini /etc/php84/conf.d/99-xdebug.ini
RUN if [ ! -f /usr/bin/php ]; then ln -s /usr/bin/php84 /usr/bin/php; fi

# Supervisor
COPY config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Composer
# https://getcomposer.org/doc/00-intro.md#docker-image
COPY --from=composer/composer:2-bin /composer /usr/bin/composer

# Set permissions
RUN chown -R cms:cmsg /var/www/html /run /var/lib/nginx /var/log/nginx

# Switch to cms-user
USER cms

# Setup git
RUN git config --global init.defaultBranch main && \
    git config --global user.email "MakeItStatic" &&\
    git config --global user.name "MakeItStatic"

# Indicate which port needs to be connected with EXPOSE metadata
EXPOSE 8080

# Run supervisord
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]

# Healthcheck
HEALTHCHECK --timeout=10s CMD curl --silent --fail http://127.0.0.1:8080/fpm-ping || exit 1
