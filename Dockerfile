# Set base image
#ARG ALPINE_VERSION=3.21.1 # This is not getting picked up by dependabot, so use hardcoded:
FROM alpine:3.21.1

# Set working directory
WORKDIR /var/www/html

# Add cms user with home dir (for git)
RUN addgroup -g 1000 cmsg && \
    adduser -D -G cmsg -u 1000 -h /home/cms -s /bin/sh cms

# Install packages
RUN apk add --no-cache \
    bash==5.2.37-r0 \
    curl==8.11.1-r0 \
    nginx==1.26.2-r4 \
    git==2.47.2-r0 \
    npm==10.9.1-r0 \
    php84==8.4.3-r0 \
    php84-ctype==8.4.3-r0 \
    php84-curl==8.4.3-r0 \
    php84-dom==8.4.3-r0 \
    php84-fileinfo==8.4.3-r0 \
    php84-fpm==8.4.3-r0 \
    php84-gd==8.4.3-r0 \
    php84-iconv==8.4.3-r0 \
    php84-intl==8.4.3-r0 \
    php84-mbstring==8.4.3-r0 \
    php84-mysqli==8.4.3-r0 \
    php84-opcache==8.4.3-r0 \
    php84-openssl==8.4.3-r0 \
    php84-pecl-xdebug==3.4.1-r0 \
    php84-phar==8.4.3-r0 \
    php84-session==8.4.3-r0 \
    php84-simplexml==8.4.3-r0 \
    php84-tokenizer==8.4.3-r0 \
    php84-xml==8.4.3-r0 \
    php84-xmlreader==8.4.3-r0 \
    php84-xmlwriter==8.4.3-r0 \
    supervisor==4.2.5-r5

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
