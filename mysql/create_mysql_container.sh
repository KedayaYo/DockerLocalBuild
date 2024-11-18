#!/bin/bash

# 清除原容器信息
CONTAINER_NAME="mysql_server" # 容器名称/服务名
IMAGE_TAG="mysql:8"      # 镜像标签
LOG_DIR="$(pwd)/logs"         # 日志文件目录
DATA_DIR="$(pwd)/data"        # 数据文件目录
CONF_DIR="$(pwd)/conf"        # 配置文件目录
INIT_SQL_DIR="$(pwd)/sql/"    # 初始化数据SQL脚本目录
IS_CREATE_NETWORK=false       # 是否创建网络组
NET_WORK="fcsNet"             # 网络组
SERVER_IP="172.18.0.2"        # 服务器IP
USER_NAME="root"              # 用户名
PASSWORD="mysql_3306"         # 密码
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

echo -e "\n \033[34m ########## 容器 $CONTAINER_NAME 开始构建 ########## \033[0m"

# 创建网络组
GreenEcho "Step 0: 创建网络组-$NET_WORK"
if "$IS_CREATE_NETWORK"; then
    docker network create -d bridge \
        --subnet 172.18.0.0/24 \
        --gateway 172.18.0.1 \
        $NET_WORK
    docker network inspect "$NET_WORK"
else
    echo "网络组已存在，无需创建网络组"
fi

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
    --user=root \
    --privileged=true \
    --restart always \
    --ip $SERVER_IP \
    --network $NET_WORK \
    --hostname $CONTAINER_NAME \
    --publish 3306:3306 \
    --volume $CONF_DIR/my.cnf:/etc/mysql/my.cnf:ro \
    --volume $DATA_DIR:/var/lib/mysql \
    --volume $LOG_DIR:/var/log/mysql \
    --volume $INIT_SQL_DIR:/opt/sql:ro \
    --volume $(pwd)/init:/docker-entrypoint-initdb.d \
    --env TZ=Asia/Shanghai \
    --env MYSQL_ROOT_PASSWORD="$PASSWORD" \
    $IMAGE_TAG

# --volume /etc/localtime:/etc/localtime \
# --volume $(pwd)/init:/docker-entrypoint-initdb.d \

sleep 5
GreenEcho "Step 6: 容器状态"
docker ps -a -f name=$CONTAINER_NAME

sleep 2
GreenEcho "Step 7: 容器网络"
docker network inspect $NET_WORK

sleep 3
GreenEcho "Step 8: 容器日志"
docker logs --tail 100 $CONTAINER_NAME

GreenEcho "Step 9: 容器信息"
WhiteEcho "容器Host:$CONTAINER_NAME\t容器IP:$SERVER_IP\t开放端口:3306\t用户名:$USER_NAME\t密码:$PASSWORD"
WhiteEcho "docker exec -it -u root $CONTAINER_NAME /bin/bash -c 'mysql -h127.0.0.1 -uroot -P3306 -p$mysql_password --default-character-set=utf8mb4'"

echo -e "\n \033[34m ########## 容器 $CONTAINER_NAME 构建结束 ########## \033[0m"
