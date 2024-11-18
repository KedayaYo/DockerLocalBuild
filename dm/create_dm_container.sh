#!/bin/bash
# 清除原容器信息
container_name="dm8"

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

# 清除原数据
data_dir="$(pwd)/data"
if [ ! -e "$data_dir" ]; then
    mkdir $data_dir
else
    if [ $(ls -A "$data_dir" | wc -l) -gt 0 ]; then
        rm -rf $data_dir/*
    fi
fi

# 清除历史日志
logs_dir="$(pwd)/logs"
if [ ! -e "$logs_dir" ]; then
    mkdir $logs_dir
else
    if [ $(ls -A "$logs_dir" | wc -l) -gt 0 ]; then
        rm -rf $logs_dir/*
    fi
fi

# 加载镜像
image_tag="dm8_single:dm8_20241022_rev244896_x86_rh6_64"
# 检查Docker中是否已加载镜像
if docker images --format "{{.Repository}}:{{.Tag}}" | grep -q "$image_tag"; then
    echo "$image_tag 镜像已加载"
else
    # 拉取镜像
    # docker pull $image_tag

    # 导入镜像
    echo "$image_tag 镜像正在导入..."
    docker load -i $(pwd)/dm8_20241022_x86_rh6_64_single.tar
    if [ $? -eq 0 ]; then
        echo "$image_tag 导入成功."
    else
        echo "$image_tag 导入失败，请检查路径和权限."
        exit 1
    fi
fi

# 构建容器
username="SYSDBA"
password="SYSDBA001"
local_ip="172.18.0.5"
port=5236
docker run -itd \
    --name $container_name \
    --user root \
    --privileged=true \
    --restart always \
    --ip $local_ip \
    --hostname $container_name \
    --net fcsNet \
    --publish $port:5236 \
    --volume $(pwd)/logs:/opt/dmdbms/log \
    --volume $(pwd)/data:/opt/dmdbms/data \
    --env CASE_SENSITIVE=0 \
    --env UNICODE_FLAG=1 \
    --env LENGTH_IN_CHAR=1 \
    --env PAGE_SIZE=16 \
    --env EXTENT_SIZE=32 \
    --env BLANK_PAD_MODE=1 \
    --env LOG_SIZE=1024 \
    --env LD_LIBRARY_PATH=/opt/dmdbms/bin \
    --env INSTANCE_NAME=DMSERVER \
    $image_tag

# CASE_SENSITIVE=0 设置大小写不敏感 0:不敏感 1:敏感
# LENGTH_IN_CHAR=1 VARCHAR 类型对象的长度以字符为单位
# UNICODE_FLAG 字符集 (0)，可选值: 0[GB18030], 1[UTF-8], 2[EUC-KR]
# INSTANCE_NAME：初始化数据库实例名称，默认为DMSERVER

sleep 3

docker ps -a -f name=$container_name

sleep 2

echo "容器IP:$local_ip 容器Host:$container_name 上报端口:$port 用户名:$username 密码:$password"
echo 'docker exec -it "$container_name" /bin/bash -c "source /etc/profile && cd /opt/dmdbms/bin && ./disql"'
