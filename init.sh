#!/bin/bash

set -e

source secrets.cfg

docker pull wonderfall/nextcloud && docker pull mariadb:10
docker run -d --name db_nextcloud \
	-v /mnt/nextcloud/db:/var/lib/mysql \
	-e MYSQL_ROOT_PASSWORD="${MYSQL_PASSWORD}" \
	-e MYSQL_DATABASE=nextcloud \
	-e MYSQL_USER=nextcloud \
	-e MYSQL_PASSWORD="${MYSQL_PASSWORD}" \
	mariadb:10

docker run -d --name nextcloud \
	--link db_nextcloud:db_nextcloud \
	-e UID=1000 \
	-e GID=1000 \
	-v /mnt/nextcloud/data:/data \
	-v /mnt/nextcloud/config:/config \
	-v /mnt/nextcloud/apps:/apps2 \
	-p 90:80 \
	wonderfall/nextcloud

