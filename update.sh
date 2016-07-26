#!/bin/bash

set -e

source secrets.cfg

docker pull wonderfall/nextcloud
docker rm -f nextcloud
docker run -d --name nextcloud \
	--link db_nextcloud:db_nextcloud \
	-e UID=1000 \
	-e GID=1000 \
	-v /mnt/nextcloud/data:/data \
	-v /mnt/nextcloud/config:/config \
	-v /mnt/nextcloud/apps:/apps2 \
	-p 90:80 \
	wonderfall/nextcloud

