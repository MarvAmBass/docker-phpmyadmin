# phpmyadmin - (marvambass/phpmyadmin) (+ optional tls) on debian, apache2 [x86 + arm]

_maintained by MarvAmBass_

## What is it

This Dockerfile (available as ___marvambass/phpmyadmin___) gives you a ready to use phpmyadmin installation with optional tls.

Note: This container only supports `mysql` / `mariadb` database servers.
There is no internal mysql-server available - so you need to setup a seconds container for that (take a look at `docker-compose.yml`)

View in Docker Registry [marvambass/phpmyadmin](https://hub.docker.com/r/marvambass/phpmyadmin)

View in GitHub [MarvAmBass/docker-phpmyadmin](https://github.com/MarvAmBass/docker-phpmyadmin)

This Dockerfile is based on the [marvambass/apache2-ssl-secure](https://registry.hub.docker.com/u/marvambass/apache2-ssl-secure/) `debian:10` based image.

## Changelogs

* 2021-08-27
    * complete rework
    * new inital commit
    * multiarch build

## How to use

This container needs to connect to a database, so take a look at the `docker-compose.yml`

## Environment variables and defaults

* __DB\_HOST__
 * host of mysql db
 * default: `db`

* __SECRET__
 * phpmyadmin `blowfish_secret` - should be a 32 character string
 * default: _auto generated string using: `pwgen 32 1`_

### BASEIMAGE: Environment variables and defaults

* __DISABLE\_TLS__
 * default: not set - if set yo any value `https` and the `HSTS_HEADERS_*` will be disabled

* __HSTS\_HEADERS\_ENABLE__
 * default: not set - if set to any value the HTTP Strict Transport Security will be activated on SSL Channel

* __HSTS\_HEADERS\_ENABLE\_NO\_SUBDOMAINS__
 * default: not set - if set together with __HSTS\_HEADERS\_ENABLE__ and set to any value the HTTP Strict Transport Security will be deactivated on subdomains

