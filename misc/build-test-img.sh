#!/bin/bash

# 每个项目的name要求不一样
IMAGE_NAME=fpms_saas_template
IMAGE=${IMAGE_NAME}`date +'%Y%m%d%H%M'`
# TODO 区分环境
DOCKER_FILE="test.Dockerfile"

echo ${IMAGE}

# 打包
docker build -t $IMAGE . -f $DOCKER_FILE

# 将镜像里打包的文件拷贝到本地
docker run -itd --name ${IMAGE_NAME} ${IMAGE}:latest /bin/bash
docker cp ${IMAGE_NAME}:/app/dist ./dist
docker rm -f ${IMAGE_NAME}

# 删除打包镜像
docker rmi ${IMAGE}
