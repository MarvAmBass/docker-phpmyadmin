FROM marvambass/apache2-ssl-secure:latest

RUN apt-get -q -y update && \
    apt-get -q -y install mariadb-client \
                          php-mysql \
                          php-xml \
                          php-gd \
                          php-mbstring \
                          pwgen \
                          wget && \
    apt-get -q -y clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    \
    rm -rf /var/www/html/* && \
    cd /var/www/html && \
    wget -O - https://www.phpmyadmin.net/downloads/phpMyAdmin-latest-all-languages.tar.gz | tar xzvf - && \
    mv php* phpmyadmin && \
    cp phpmyadmin/config.sample.inc.php phpmyadmin/config.inc.php && \
    \
    chmod 660 /var/www/html/phpmyadmin/config.inc.php && \
    chown -R www-data:www-data /var/www/html/phpmyadmin

COPY config/www/index.php /var/www/html/index.php
COPY config/runit/phpmyadmin /container/config/runit/phpmyadmin

COPY . /container-2