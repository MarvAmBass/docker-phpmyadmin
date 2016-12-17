#/bin/bash

###
# Pre Install
###

if [ ! -z ${PHPMYADMIN_HSTS_HEADERS_ENABLE+x} ]
then
  echo ">> HSTS Headers enabled"
  sed -i 's/#add_header Strict-Transport-Security/add_header Strict-Transport-Security/g' /etc/nginx/conf.d/nginx-phpmyadmin.conf

  if [ ! -z ${PHPMYADMIN_HSTS_HEADERS_ENABLE_NO_SUBDOMAINS+x} ]
  then
    echo ">> HSTS Headers configured without includeSubdomains"
    sed -i 's/; includeSubdomains//g' /etc/nginx/conf.d/nginx-phpmyadmin.conf
  fi
else
  echo ">> HSTS Headers disabled"
fi

###
# Install
###

PHPMYADMIN_RANDOM=`perl -e 'my @chars = ("A".."Z", "a".."z"); my $string; $string .= $chars[rand @chars] for 1..46; print $string;'` # returns exactly 46 random chars
sed -i "s/DOCKER_RANDOM/$PHPMYADMIN_RANDOM/g" /phpmyadmin/config.inc.php
echo ">> switched PHPmyAdmin 'blowfish_secret'"

if [ ! -z ${PHPMYADMIN_MYSQL_HOST+x} ]
then
  sed -i "s/'mysql'/'$PHPMYADMIN_MYSQL_HOST'/g" /phpmyadmin/config.inc.php
  echo ">> switched MYSQL Host to: $PHPMYADMIN_MYSQL_HOST"
fi

if [ ! -z ${PHPMYADMIN_MYSQL_PORT+x} ]
then
  sed -i "s/'3306'/'$PHPMYADMIN_MYSQL_PORT'/g" /phpmyadmin/config.inc.php
  echo ">> switched MYSQL Port to: $PHPMYADMIN_MYSQL_PORT"
fi

if [ -z ${PHPMYADMIN_RELATIVE_URL_ROOT+x} ]
then
  PHPMYADMIN_RELATIVE_URL_ROOT="/"
fi

echo ">> making phpmyadmin available beneath: $PHPMYADMIN_RELATIVE_URL_ROOT"
mkdir -p "/usr/share/nginx/html$PHPMYADMIN_RELATIVE_URL_ROOT"
cp -a /phpmyadmin/* "/usr/share/nginx/html$PHPMYADMIN_RELATIVE_URL_ROOT"
