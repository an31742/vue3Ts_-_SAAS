#!/bin/bash

set -e

# 生产环境/预览环境build
build_type=$1

export PATH="/home/node16/bin:$PATH"
node -v
npm -v 
yarn 
yarn run build:$build_type
