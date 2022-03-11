
FROM ccr.ccs.tencentyun.com/aiforward_saas_fe/fe_fpms_build:202107141358  AS builder

#ARG build_type=prod
# 每一个项目都不同 fpms_saas_template 根据vue.config.js中的publicpath而来
ARG tencent_path_name=fpms_saas_template
WORKDIR /app/
COPY . /app/

RUN /usr/local/bin/coscmd upload -rsf /app/dist fe/src/$tencent_path_name/dist

FROM nginx:stable-alpine

ADD ./misc/default.conf /etc/nginx/conf.d/default.conf
ADD ./misc/nginx.conf /etc/nginx/nginx.conf
COPY --from=builder /app/dist /usr/share/nginx/html
# 修改根目录权限,否则回产生403权限访问问题
RUN chmod -R 777 /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
