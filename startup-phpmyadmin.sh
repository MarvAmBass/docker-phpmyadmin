#/bin/bash

MY_RANDOM=`perl -e 'my @chars = ("A".."Z", "a".."z"); my $string; $string .= $chars[rand @chars] for 1..46; print $string;'` # returns exactly 46 random chars
sed -i "s/DOCKER_RANDOM/$MY_RANDOM/g" /usr/share/nginx/html/phpmyadmin/config.inc.php
echo ">> switched PHPmyAdmin 'blowfish_secret'"

if [ -z ${MY_MYSQL_PORT+x} ]
then
  sed -i "s/'3306'/'$MY_MYSQL_PORT'/g" /usr/share/nginx/html/phpmyadmin/config.inc.php
  echo ">> switched MYSQL Port to: $MY_MYSQL_PORT"
fi
