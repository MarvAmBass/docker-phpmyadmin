# Docker phpMyAdmin Container (based on marvambass/phpmyadmin)
_maintained by MarvAmBass_

## What is it

This Dockerfile (available as ___marvambass/phpmyadmin___) gives you a completly secure phpMyAdmin.

The best is to just start this container if it's needed. And keep it stopped afterwarts.

It's based on the [marvambass/nginx-ssl-php](https://registry.hub.docker.com/u/marvambass/nginx-ssl-php/) Image

View in Docker Registry [marvambass/phpmyadmin](https://registry.hub.docker.com/u/marvambass/phpmyadmin/)

View in GitHub [MarvAmBass/docker-phpmyadmin](https://github.com/MarvAmBass/docker-phpmyadmin)

## Environment variables and defaults

* __DH\_SIZE__
 * default: 512 fast but a bit unsecure. if you need more security just use a higher value
* __PHPMYADMIN\_MYSQL\_PORT__
 * default: _3306_ - if you use a different mysql port change it
* __PHPMYADMIN\_RELATIVE\_URL\_ROOT__
 * default: _/_ - you can chance that to /phpmyadmin or what you need
* __PHPMYADMIN\_HSTS\_HEADERS\_ENABLE__
 * default: not set - if set to any value the HTTP Strict Transport Security will be activated on SSL Channel
* __PHPMYADMIN\_HSTS\_HEADERS\_ENABLE\_NO\_SUBDOMAINS__
 * default: not set - if set together with __PHPMYADMIN\_HSTS\_HEADERS\_ENABLE__ and set to any value the HTTP Strict Transport Security will be deactivated on subdomains

## Using the marvambass/phpmyadmin Container

First you need a running MySQL Container (you could use: [marvambass/mysql](https://registry.hub.docker.com/u/marvambass/mysql/)).

You need to _--link_ your mysql container to marvambass/phpmyadmin with the name __mysql__

    docker run -d -p 443:443 --link mysql:mysql --name phpmyadmin marvambass/phpmyadmin
