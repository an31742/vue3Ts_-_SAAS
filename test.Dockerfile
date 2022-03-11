FROM node:14.18.2

WORKDIR /app/
COPY ./ /app/

RUN npm install
# TODO 区分环境
RUN npm run build:test
