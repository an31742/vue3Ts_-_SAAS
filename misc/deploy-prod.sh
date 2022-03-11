#!/bin/bash

set -e

# 命令：sh ./misc/build-push-img.sh prod   sh ./misc/build-push-img.sh pre
# 生产/预览环境deploy
script_name=`basename $0`
build_type=$1

usage() {
    echo "${script_name} [build_type prod=<正式环境> | pre=<灰度环境>]"
}

DOCKER_FILE="Dockerfile"
IMAGE_NAME="fe_fpms_saas_template_prod"
case $build_type in
pre)
    IMAGE_NAME="fe_fpms_saas_template_pre"
    ;;
prod)
    ;;
*)
    usage
    exit 1
    ;;
esac

IMAGE_PREFIX=ccr.ccs.tencentyun.com/aiforward_saas_fe/${IMAGE_NAME}
IMAGE_TAG=`date +'%Y%m%d%H%M'`-`git rev-parse --short HEAD`
IMAGE=$IMAGE_PREFIX:${IMAGE_TAG}
echo "------------------------------"
echo "Make sure docker login first!"
echo "Run the followings..."
echo "docker login ccr.ccs.tencentyun.com"
echo ""
echo "Git branch: "`git rev-parse --abbrev-ref HEAD`
echo "Git SHA   : "`git rev-parse HEAD`
echo "Image     : ${IMAGE}"
echo ""
echo "Press any to continue, Ctrl + C to cancel"
#read p

echo "=> Buiding image: $IMAGE And build_type=$build_type"

# 打印服务器ip地址
# ifconfig

docker build -t $IMAGE . -f $DOCKER_FILE --build-arg build_type=$build_type
echo "=> Pushing image: $IMAGE"
docker push $IMAGE

#打包完成后删除镜像
docker rmi $IMAGE
