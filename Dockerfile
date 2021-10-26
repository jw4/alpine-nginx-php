FROM alpine:3


LABEL maintainer="John Weldon <john@tempusbreve.com>" \
  description="Alpine Based PHP Hosting" \
  vendor="Tempus Breve Software"

RUN apk update && \
    apk upgrade && \
    apk add \
        bash \
        ca-certificates \
        curl \
        nginx \
        openssh \
        php7 \
        php7-bcmath \
        php7-ctype \
        php7-curl \
        php7-dom \
        php7-exif \
        php7-fileinfo \
        php7-fpm \
        php7-gd \
        php7-iconv \
        php7-imagick \
        php7-json \
        php7-mysqli \
        php7-openssl \
        php7-posix \
        php7-ssh2 \
        php7-xml \
        php7-xmlreader \
        php7-zip \
        php7-zlib \
        supervisor \
        tar \
        vim \
    && mkdir -p /etc/skel \
    && (cd /etc/skel ; curl -sL https://github.com/johnweldon/tiny-profile/archive/v0.1.9.tar.gz | tar --strip-components 1 -xzf -) \
    && mkdir -p /run/nginx \
    && rm -rf /var/www/* \
    && rm -rf /var/cache/apk/*

RUN sed -i -e 's/^short_open_tag = Off/short_open_tag = On/' /etc/php7/php.ini              ; \
    sed -i -e 's/^max_execution_time = .*$/max_execution_time = 180/g' /etc/php7/php.ini    ; \
    sed -i -e 's/^post_max_size = .*$/post_max_size = 64M/g' /etc/php7/php.ini              ; \
    sed -i -e 's/^upload_max_filesize = .*$/upload_max_filesize = 64M/g' /etc/php7/php.ini  ; \
    sed -i -e 's/^; max_input_vars = .*$/max_input_vars = 3000;/g' /etc/php7/php.ini  ; \
    sed -i -e 's/^;error_log = .*$/error_log = syslog/g' /etc/php7/php-fpm.conf              ; \
    sed -i -e 's/^#PasswordAuthentication yes$/PasswordAuthentication no/g' /etc/ssh/sshd_config

COPY ./script /script
COPY ./conf /conf
COPY ./nginx /etc/nginx

EXPOSE 80 22

VOLUME ["/var/www/","/conf/sshd"]

ENTRYPOINT ["/script/entrypoint.sh"]

CMD ["serve"]
