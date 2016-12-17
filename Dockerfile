FROM marvambass/nginx-ssl-php
MAINTAINER MarvAmBass

ENV DH_SIZE 1024

RUN apt-get -q -y update && \
    apt-get -q -y install mysql-client \
                          php5-mysql \
                          php5-gd \
                          php5-mcrypt \
                          wget \
                          unzip && \
    apt-get -q -y clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*;

RUN php5enmod mcrypt
RUN sed -i 's/upload_max_filesize = 2M/upload_max_filesize = 2000M/g' /etc/php5/fpm/php.ini

# clean http directory
RUN rm -rf /usr/share/nginx/html/*

# install nginx phpmyadmin config
ADD nginx-phpmyadmin.conf /etc/nginx/conf.d/nginx-phpmyadmin.conf

RUN wget "https://files.phpmyadmin.net/phpMyAdmin/4.6.5.2/phpMyAdmin-4.6.5.2-all-languages.zip" -O phpMyAdmin.zip && \
    unzip phpMyAdmin.zip && \
    rm phpMyAdmin.zip; \
    mv phpMyAdmin-*-languages /phpmyadmin


# install personal phpmyadmin config
ADD config.inc.php /phpmyadmin/config.inc.php
RUN rm -rf /phpmyadmin/config; echo "deleted config folder"

# add startup.sh
ADD startup-phpmyadmin.sh /opt/startup-phpmyadmin.sh
RUN chmod a+x /opt/startup-phpmyadmin.sh

# add '/opt/startup-phpmyadmin.sh' to entrypoint.sh
RUN sed -i 's/#!\/bin\/bash/#!\/bin\/bash\n\/opt\/startup-phpmyadmin.sh/g' /opt/entrypoint.sh
