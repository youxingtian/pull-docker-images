#!/bin/bash
#push google or coreos images to dockerhub or aliyun registry

set -e
set -u

for imagepath in $(cat ./imagepath.txt)
do
imagename=$(echo $imagepath | awk -F '/' '{print $NF}')
docker pull $imagepath
# push到阿里云仓库
docker tag $imagepath registry.cn-hangzhou.aliyuncs.com/aliwill/$imagename
docker push registry.cn-hangzhou.aliyuncs.com/aliwill/$imagename
# push到dockerhub
docker tag $imagepath willdockerhub/$imagename
docker push willdockerhub/$imagename
done
