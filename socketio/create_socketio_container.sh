#!/bin/bash

container_name="socket_server"
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
image_tag="socketio:3.0.4"
# 检查Docker中是否已加载镜像
if docker images --format "{{.Repository}}:{{.Tag}}" | grep -q "$image_tag"; then
    echo "$image_tag 镜像已加载"
else
    echo "$image_tag 镜像正在加载..."
    docker load -i $(pwd)/redis.tar
    if [ $? -eq 0 ]; then
        echo "$image_tag 加载成功."
    else
        echo "$image_tag 加载失败，请检查路径和权限."
        exit 1
    fi
fi

publish_port=8087
local_ip="172.18.0.6"
docker run -itd \
    --name $container_name \
    --restart always \
    --ip $local_ip \
    --network fcsNet \
    --hostname $container_name \
    --publish $publish_port:8087 \
    --volume $(pwd)/logs:/qicloud/logs \
    --volume $(pwd)/config:/qicloud/config \
    $image_tag

sleep 5

docker ps -a -f name=$container_name

sleep 3
docker logs --tail 20 $container_name

echo "容器IP:$local_ip 容器Host:$container_name 访问端口:$publish_port"
echo "docker exec -it -u root $container_name /bin/bash"
