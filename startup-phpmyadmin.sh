#/bin/bash

PHPMYADMIN_RANDOM=`perl -e 'my @chars = ("A".."Z", "a".."z"); my $string; $string .= $chars[rand @chars] for 1..46; print $string;'` # returns exactly 46 random chars
sed -i "s/DOCKER_RANDOM/$PHPMYADMIN_RANDOM/g" /phpmyadmin/config.inc.php
echo ">> switched PHPmyAdmin 'blowfish_secret'"

if [ ! -z ${PHPMYADMIN_MYSQL_PORT+x} ]
then
  sed -i "s/'3306'/'$PHPMYADMIN_MYSQL_PORT'/g" /phpmyadmin/config.inc.php
  echo ">> switched MYSQL Port to: $PHPMYADMIN_MYSQL_PORT"
fi

if [ ! -z ${PHPMYADMIN_RELATIVE_URL_ROOT+x} ]
then
  PHPMYADMIN_RELATIVE_URL_ROOT="/" 
fi

mkdir -p "/usr/share/nginx/html$PHPMYADMIN_RELATIVE_URL_ROOT"
mv /phpmyadmin/* "/usr/share/nginx/html$PHPMYADMIN_RELATIVE_URL_ROOT"
