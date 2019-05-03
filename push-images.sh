#!/bin/bash
#push google or coreos images to dockerhub or aliyun registry,
#change the registry name and username/password to yourself's.

set -e
set -u

DOCKER_HUB=willdockerhub
ALI_REGISTRY=registry.cn-hangzhou.aliyuncs.com/aliwill

for image in $(cat img-list.txt)
do
	imagename=$(echo $image | awk -F '/' '{print $NF}')
	docker pull $image
	docker tag $image $ALI_REGISTRY/$imagename
	docker tag $image $DOCKER_HUB/$imagename
	# push到阿里云仓库
	docker push $ALI_REGISTRY/$imagename && \
	# push到dockerhub
	docker push $DOCKER_HUB/$imagename
done
