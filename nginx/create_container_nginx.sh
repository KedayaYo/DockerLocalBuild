#!/bin/bash

# 清除历史日志
logs_dir="./logs"
if [ ! -e "$logs_dir" ]; then
    echo "创建日志挂载目录"
    mkdir $logs_dir
elif [ $(ls -A "$logs_dir" | wc -l) -gt 0 ]; then
    echo "清除挂载日志数据"
    rm -rf $logs_dir/*
fi

# 清除原容器信息
container_name="nginx"
# 检查容器是否存在
if docker ps -a --format "{{.Names}}" | grep -q "$container_name"; then
    echo "正在停止容器 $container_name ..."
    docker stop $container_name
    echo "正在删除容器 $container_name ..."
    docker rm -vf $container_name
    echo "容器 $container_name 已删除"
else
    echo "容器不存在,无需操作"
fi

# 加载镜像
image_tag="nginx:latest"
# 检查Docker中是否已加载镜像
if docker images --format "{{.Repository}}:{{.Tag}}" | grep -q "$image_tag"; then
    echo "$image_tag 镜像已加载"
else
    docker pull nginx:latest
    # echo "$image_tag 镜像正在加载..."
    # docker load -i nginx_1.25.2_arm64.tar
    # if [ $? -eq 0 ]; then
    #     echo "$image_tag 加载成功."
    # else
    #     echo "$image_tag 加载失败，请检查路径和权限."
    #     exit 1
    # fi
fi

# 容器分配IP
local_ip="172.18.0.7"
docker run -itd \
    --name $container_name \
    --restart always \
    --ip $local_ip \
    --name $container_name \
    --network fcsNet \
    --publish 443:443 \
    --publish 80:80 \
    --publish 81:81 \
    --publish 82:82 \
    -v $(pwd)/config/nginx.conf:/etc/nginx/nginx.conf \
    -v $(pwd)/config/conf.d:/etc/nginx/conf.d \
    -v $(pwd)/logs:/var/log/nginx \
    -v $(pwd)/html:/usr/share/nginx/html \
    -v $(pwd)/../flight_sys_server/static:/usr/share/nginx/static \
    $image_tag

sleep 5
docker ps -a -f name=$container_name

sleep 3
docker logs --tail 100 $container_name

sleep 1
docker network inspect fcsNet

sleep 2
echo "容器IP:$local_ip 容器Host:$container_name 访问端口:443、80-90"
echo "docker exec -it -u root $container_name /bin/bash"
