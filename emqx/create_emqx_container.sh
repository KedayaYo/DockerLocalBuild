#!/bin/bash

CONTAINER_NAME="mqtt_server"           # 容器名称/服务名
IMAGE_TAG="emqx/emqx:latest" # 镜像标签
LOG_DIR="$(pwd)/logs"                  # 日志文件目录
DATA_DIR="$(pwd)/data"                 # 数据文件目录
CONF_DIR="$(pwd)/config"               # 配置文件目录
NET_WORK="fcsNet"                      # 网络组
SERVER_IP="172.18.0.4"                 # 服务器IP
USER_NAME="root"                       # 用户名
PASSWORD="emqx_1883"                   # 密码
CLEAR_DATA=false                       # 是否清除原数据

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
elif [ $(ls -A "$LOG_DIR" | wc -l) -gt 0 ]; then
    WhiteEcho "清除挂载日志数据"
    rm -rf $LOG_DIR/*
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
    --user root \
    --privileged=true \
    --restart always \
    --ip $SERVER_IP \
    --hostname $CONTAINER_NAME \
    --network $NET_WORK \
    --publish 1883:1883 \
    --publish 8083:8083 \
    --publish 8084:8084 \
    --publish 8883:8883 \
    --publish 18083:18083 \
    --volume $LOG_DIR:/opt/emqx/log \
    --volume $DATA_DIR:/opt/emqx/data \
    --env TZ=Asia/Shanghai \
    --env EMQX_DASHBOARD_DEFAULT_USER_LOGIN="$USER_NAME" \
    --env EMQX_DASHBOARD_DEFAULT_USER_PASSWORD="$PASSWORD" \
    $IMAGE_TAG

# --volume $CONF_DIR:/opt/emqx/etc \ / 映射配置文件

sleep 5
GreenEcho "Step 6: 容器状态"
docker ps -a -f name=$CONTAINER_NAME

sleep 3
GreenEcho "Step 7: 容器日志"
docker logs --tail 100 $CONTAINER_NAME

GreenEcho "Step 8: 容器信息"
WhiteEcho "容器Host:$CONTAINER_NAME\t容器IP:$SERVER_IP\t开放端口:1883、8083、8084、8883、18083\t用户名:$USER_NAME\t密码:$PASSWORD\t终端连接端口:1883\t免费终端连接数:25"
WhiteEcho "Web-Dashbord:http://127.0.0.1:18083\t用户名:admin\t密码:public"
WhiteEcho "Dashbord 使用默认用户名密码登陆后会要求修改密码,默认请修改为:emqx_18083"
WhiteEcho "docker exec -it -u root $CONTAINER_NAME /bin/bash"

GreenEcho "########## 容器 $CONTAINER_NAME 构建结束 ##########"
