#!/bin/bash

echo "Updating www-data uid and gid"

WWW_ROOT=/var/www/html

DOCKER_UID=`stat -c "%u" $WWW_ROOT`
DOCKER_GID=`stat -c "%g" $WWW_ROOT`

INCUMBENT_USER=`getent passwd $DOCKER_UID | cut -d: -f1`
INCUMBENT_GROUP=`getent group $DOCKER_GID | cut -d: -f1`

echo "Docker: uid = $DOCKER_UID, gid = $DOCKER_GID"
echo "Incumbent: user = $INCUMBENT_USER, group = $INCUMBENT_GROUP"

# Once we've established the ids and incumbent ids then we need to free them
# up (if necessary) and then make the change to www-data.

#[ ! -z "${INCUMBENT_USER}" ] && usermod -u 99$DOCKER_UID $INCUMBENT_USER
#usermod -u $DOCKER_UID www-data

#[ ! -z "${INCUMBENT_GROUP}" ] && groupmod -g 99$DOCKER_GID $INCUMBENT_GROUP
#groupmod -g $DOCKER_GID www-data

#cd /var/www/html
#find . -type d -exec chmod 700 {} \; && find . -type f -exec chmod 600 {} \;
php-fpm -R -F