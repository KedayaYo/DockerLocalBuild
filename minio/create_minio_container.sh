#!/bin/bash

CONTAINER_NAME="minio_server"  # 容器名称/服务名
IMAGE_TAG="minio/minio:latest" # 镜像标签
LOG_DIR="$(pwd)/logs"          # 日志文件目录
DATA_DIR="$(pwd)/data"         # 数据文件目录
CONF_DIR="$(pwd)/config"       # 配置文件目录
NET_WORK="fcsNet"              # 网络组
SERVER_IP="172.18.0.6"         # 服务器IP
USER_NAME="minioadmin"         # 用户名
PASSWORD="minio_9000"          # 密码
CLEAR_DATA=false               # 是否清除原数据

##
# 绿色输出
##
step_index=0
function GreenEcho() {
    step_index=$((step_index + 1))
    echo -e "\n \033[34m Step $step_index: ${1} \033[0m"
}

##
# 白色输出
##
function WhiteEcho() {
    echo -e "\t- ${1}"
}

echo -e "\n \033[34m ########## 容器 $CONTAINER_NAME 开始构建 ########## \033[0m"

GreenEcho "容器检查-$CONTAINER_NAME"
if docker ps -a --format "{{.Names}}" | grep -q "$CONTAINER_NAME"; then
    WhiteEcho "容器停止中..."
    docker stop $CONTAINER_NAME
    WhiteEcho "容器清理中..."
    docker rm -vf $CONTAINER_NAME
    WhiteEcho "容器已清理"
else
    WhiteEcho "未检测到同名容器"
fi

GreenEcho "镜像检查-$IMAGE_TAG"
if docker images --format "{{.Repository}}:{{.Tag}}" | grep -q "$IMAGE_TAG"; then
    WhiteEcho "$IMAGE_TAG 镜像已加载"
else
    WhiteEcho "远程镜像加载中...[docker pull $IMAGE_TAG]"
    docker pull $IMAGE_TAG
    WhiteEcho "镜像加载完毕"
fi
WhiteEcho "镜像信息"
docker images --filter=reference="$IMAGE_TAG"

GreenEcho "日志文件清理-$LOG_DIR"
if [ ! -e "$LOG_DIR" ]; then
    WhiteEcho "创建日志挂载目录"
    mkdir $LOG_DIR
elif [ $(ls -A "$LOG_DIR" | wc -l) -gt 0 ]; then
    WhiteEcho "清除挂载日志数据"
    rm -rf $LOG_DIR/*
    WhiteEcho "日志清除完毕"
fi

GreenEcho "数据文件清理-$DATA_DIR"
if [ ! -e "$DATA_DIR" ]; then
    WhiteEcho "创建数据挂载目录"
    mkdir $DATA_DIR
elif [ $(ls -A "$DATA_DIR" | wc -l) -gt 0 ] && $CLEAR_DATA; then
    WhiteEcho "清除原挂载数据"
    rm -rf $DATA_DIR/*
    WhiteEcho "数据清理完毕"
fi

GreenEcho "容器构建-$CONTAINER_NAME"
docker run -d \
    --name $CONTAINER_NAME \
    --user=root \
    --privileged=true \
    --restart always \
    --ip $SERVER_IP \
    --network $NET_WORK \
    --hostname $CONTAINER_NAME \
    --publish 9000:9000 \
    --publish 9001:9001 \
    --volume $CONF_DIR:/root/.minio \
    --volume $DATA_DIR:/data \
    --volume $LOG_DIR:/var/log \
    --env MINIO_ROOT_USER=$USER_NAME \
    --env MINIO_ROOT_PASSWORD=$PASSWORD \
    $IMAGE_TAG server /data --console-address ":9001" --address ":9000"

# --env MINIO_ROOT_USER=$USER_NAME \ // 默认
# --env MINIO_ROOT_PASSWORD=$PASSWORD \ // 默认

# 低版本标签:minio/minio:RELEASE.2021-06-14T01-29-23Z
# --env MINIO_ACCESS_KEY=$USER_NAME \ // 低版本
# --env MINIO_SECRET_KEY=$PASSWORD \ // 低版本

sleep 5
GreenEcho "容器状态"
docker ps -a -f name=$CONTAINER_NAME

sleep 3
GreenEcho "容器日志"
docker logs --tail 100 $CONTAINER_NAME

GreenEcho "容器信息"
WhiteEcho "容器Host:$CONTAINER_NAME\t容器IP:$SERVER_IP\t开放端口:9000、9090\t控制台地址:http://127.0.0.1:9001\t用户名:$USER_NAME\t密码:$PASSWORD"
WhiteEcho "API: http://172.18.0.5:9000  http://127.0.0.1:9000\t用户名:$USER_NAME\t密码:$PASSWORD"
WhiteEcho "WebUI: http://172.18.0.5:9001 http://127.0.0.1:9001\t用户名:$USER_NAME\t密码:$PASSWORD"
WhiteEcho "docker exec -it -u root $CONTAINER_NAME /bin/bash"

echo -e "\n \033[34m ########## 容器 $CONTAINER_NAME 构建结束 ########## \033[0m"
