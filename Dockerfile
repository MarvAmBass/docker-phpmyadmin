FROM marvambass/nginx-ssl-php
MAINTAINER MarvAmBass

ENV DH_SIZE 512

RUN apt-get update && apt-get install -y \
    mysql-client \
    php5-gd \
    php5-mcrypt \
    php5-mysql \
    wget \
    unzip

RUN php5enmod mcrypt
RUN sed -i 's/upload_max_filesize = 2M/upload_max_filesize = 2000M/g' /etc/php5/fpm/php.ini

RUN wget "http://sourceforge.net/projects/phpmyadmin/files/latest/download" -O phpMyAdmin.zip
RUN unzip phpMyAdmin.zip
RUN rm phpMyAdmin.zip
RUN mv phpMyAdmin-*-languages /usr/share/nginx/html/phpmyadmin

# install nginx phpmyadmin config
ADD nginx-phpmyadmin.conf /etc/nginx/conf.d/nginx-phpmyadmin.conf

# install personal phpmyadmin config
ADD config.inc.php /usr/share/nginx/html/phpmyadmin/config.inc.php
RUN rm -rf /usr/share/nginx/html/phpmyadmin/config; echo "deleted config folder"

# add startup.sh
ADD startup-phpmyadmin.sh /opt/startup-phpmyadmin.sh
RUN chmod a+x /opt/startup-phpmyadmin.sh

# add '/opt/startup-phpmyadmin.sh' to entrypoint.sh
RUN sed -i 's/#!\/bin\/bash/#!\/bin\/bash\n\/opt\/startup-phpmyadmin.sh/g' /opt/entrypoint.sh
