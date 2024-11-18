#!/bin/bash

CONTAINER_NAME="redis_server" # 容器名称/服务名
IMAGE_TAG="redis:latest"      # 镜像标签
LOG_DIR="$(pwd)/logs"         # 日志文件目录
DATA_DIR="$(pwd)/data"        # 数据文件目录
CONF_DIR="$(pwd)/config"      # 配置文件目录
NET_WORK="fcsNet"             # 网络组
SERVER_IP="172.18.0.3"        # 服务器IP
USER_NAME="root"              # 用户名
PASSWORD="redis_6379"         # 密码
CLEAR_DATA=true               # 是否清除原数据

##
# 绿色输出
##
function GreenEcho() {
    echo -e "\n \033[34m ${1} \033[0m"
}

##
# 白色输出
##
function WhiteEcho() {
    echo -e "\t- ${1}"
}

GreenEcho "########## 容器 $CONTAINER_NAME 开始构建 ##########"

GreenEcho "Step 1: 容器检查-$CONTAINER_NAME"
if docker ps -a --format "{{.Names}}" | grep -q "$CONTAINER_NAME"; then
    WhiteEcho "容器停止中..."
    docker stop $CONTAINER_NAME
    WhiteEcho "容器清理中..."
    docker rm -vf $CONTAINER_NAME
    WhiteEcho "容器已清理"
else
    WhiteEcho "未检测到同名容器"
fi

GreenEcho "Step 2: 镜像检查-$IMAGE_TAG"
if docker images --format "{{.Repository}}:{{.Tag}}" | grep -q "$IMAGE_TAG"; then
    WhiteEcho "$IMAGE_TAG 镜像已加载"
else
    WhiteEcho "远程镜像加载中...[docker pull $IMAGE_TAG]"
    docker pull $IMAGE_TAG
    WhiteEcho "镜像加载完毕"
fi
WhiteEcho "镜像信息"
docker images --filter=reference="$IMAGE_TAG"

GreenEcho "Step 3: 日志文件清理-$LOG_DIR"
if [ ! -e "$LOG_DIR" ]; then
    WhiteEcho "创建日志挂载目录"
    mkdir $LOG_DIR
    touch $LOG_DIR/redis.log
    chmod 777 $LOG_DIR/redis.log
elif [ $(ls -A "$LOG_DIR" | wc -l) -gt 0 ]; then
    WhiteEcho "清除挂载日志数据"
    echo '' >$LOG_DIR/redis.log
    WhiteEcho "日志清除完毕"
fi

GreenEcho "Step 4: 数据文件清理-$DATA_DIR"
if [ ! -e "$DATA_DIR" ]; then
    WhiteEcho "创建数据挂载目录"
    mkdir $DATA_DIR
elif [ $(ls -A "$DATA_DIR" | wc -l) -gt 0 ] && $CLEAR_DATA; then
    WhiteEcho "清除原挂载数据"
    rm -rf $DATA_DIR/*
    WhiteEcho "数据清理完毕"
fi

GreenEcho "Step 5: 容器构建-$CONTAINER_NAME"
docker run -itd \
    --name $CONTAINER_NAME \
    --restart always \
    --user root \
    --privileged=true \
    --ip $SERVER_IP \
    --hostname $CONTAINER_NAME \
    --network $NET_WORK \
    --publish 6379:6379 \
    --volume $CONF_DIR/redis.conf:/usr/local/etc/redis/redis.conf:ro \
    --volume $DATA_DIR:/data \
    --volume $LOG_DIR/redis.log:/var/log/redis/redis.log \
    --env TZ=Asia/Shanghai \
    $IMAGE_TAG redis-server /usr/local/etc/redis/redis.conf --requirepass $PASSWORD

# --volume /etc/localtime:/etc/localtime:ro \
# --volume $CONF_DIR:/opt/emqx/etc \ / 映射配置文件

sleep 5
GreenEcho "Step 6: 容器状态"
docker ps -a -f name=$CONTAINER_NAME

sleep 3
GreenEcho "Step 7: 容器日志"
docker logs --tail 100 $CONTAINER_NAME

GreenEcho "Step 8: 容器信息"
WhiteEcho "容器Host:$CONTAINER_NAME\t容器IP:$SERVER_IP\t开放端口:6379\t用户名:$USER_NAME\t密码:$PASSWORD"
WhiteEcho "docker exec -it -u root $CONTAINER_NAME /bin/bash -c 'redis-cli -p 6379'"
WhiteEcho "> auth $PASSWORD"

GreenEcho "########## 容器 $CONTAINER_NAME 构建结束 ##########"
