#!/bin/bash

# 清除原容器信息
container_name="qicloud"

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

# 清除历史日志
logs_dir="$(pwd)/logs"
if [ ! -d "$logs_dir" ]; then
    touch $logs_dir/qiclouds.log
elif [ $(ls -A "$logs_dir" | wc -l) -gt 0 ]; then
    echo nil >$(pwd)/logs/qiclouds.log
fi

# 运行程序文件
main_file="$(pwd)/main"
if [ -f "$main_file" ]; then
    chmod 777 $main_file
else
    echo "main 文件不存在"
    exit
fi

# 加载镜像
image_tag="centos:8"
# 检查Docker中是否已加载镜像
if docker images --format "{{.Repository}}:{{.Tag}}" | grep -q "$image_tag"; then
    echo "$image_tag 镜像已加载"
else
    echo "$image_tag 镜像正在加载..."
    docker load -i $(pwd)/centos_8_amd.tar
    if [ $? -eq 0 ]; then
        echo "$image_tag 加载成功."
    else
        echo "$image_tag 加载失败，请检查路径和权限."
        exit 1
    fi
fi

local_ip="172.18.0.8"
publish_port=20218
docker run -itd \
    --name $container_name \
    --user root \
    --privileged=true \
    --restart on-failure:3 \
    --ip $local_ip \
    --publish $publish_port:20219 \
    --network fcsNet \
    --hostname $container_name \
    --volume /etc/localtime:/etc/localtime:ro \
    --volume $(pwd)/main:/flight_control/main:ro \
    --volume $(pwd)/config:/flight_control/config:ro \
    --volume $(pwd)/logs:/flight_control/storage/logs \
    --workdir /flight_control \
    $image_tag /flight_control/main

sleep 3

docker ps -a -f name=$container_name

sleep 2

docker logs -f --tail 20 $container_name

echo "容器IP:$local_ip 容器Host:$container_name 开放端口:$publish_port"
echo "docker exec -it $container_name /bin/bash"
