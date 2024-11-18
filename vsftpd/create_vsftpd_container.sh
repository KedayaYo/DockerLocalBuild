#!/bin/bash

CONTAINER_NAME="ftp_server"            # 容器名称/服务名
LOG_DIR="$(pwd)/logs"                  # 日志文件目录
DATA_DIR="$(pwd)/../nginx/html/vsftpd" # 数据文件目录
CONF="$(pwd)/config/vsftpd.conf"       # ftp配置文件
NET_WORK="fcsNet"                      # 网络组
SERVER_IP="172.18.0.5"                 # 服务器IP
PASV_ADDRESS="127.0.0.1"               # 被动模式地址(对外访问地址)
USER_NAME="root"                       # 用户名
PASSWORD="vsftpd_21"                   # 密码
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

# 判断系统架构
ARCHITECTURE=$(uname -m)

# 根据系统架构选择对应的镜像和文件
if [[ "$ARCHITECTURE" == "x86_64" || "$ARCHITECTURE" == "amd64" ]]; then
    IMAGE_TAG="fauria/vsftpd:latest"  # amd64 镜像
    IMAGE_FILE="vsftpd_amd64.tar"      # amd64 解压镜像文件
elif [[ "$ARCHITECTURE" == "i386" || "$ARCHITECTURE" == "i686" ]]; then
    IMAGE_TAG="fauria/vsftpd:latest"  # amd64 镜像（32位系统上使用amd64镜像）
    IMAGE_FILE="vsftpd_amd64.tar"      # amd64 解压镜像文件
elif [[ "$ARCHITECTURE" == "aarch64" || "$ARCHITECTURE" == "armv7l" || "$ARCHITECTURE" == "armv6l" || "$ARCHITECTURE" == "arm64" ]]; then
    IMAGE_TAG="dotkevinwong/vsftpd-arm:latest"  # ARM 架构镜像
    IMAGE_FILE="vsftpd_arm.tar"      # ARM 解压镜像文件
else
    echo "不支持的架构: $ARCHITECTURE"
    exit 1
fi

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
    WhiteEcho "镜像未加载，开始加载镜像..."
    if [ -f "$IMAGE_FILE" ]; then
        docker load < "$IMAGE_FILE"  # 使用 load 命令加载镜像
        WhiteEcho "镜像加载完毕"
    else
        WhiteEcho "未找到镜像文件 $IMAGE_FILE，请确认文件存在"
        exit 1
    fi
fi
WhiteEcho "镜像信息"
docker images --filter=reference="$IMAGE_TAG"

GreenEcho "日志文件清理-$LOG_DIR"
if [ ! -e "$LOG_DIR" ]; then
    WhiteEcho "创建日志挂载目录"
    mkdir $LOG_DIR
elif [ $(ls -A "$LOG_DIR" | wc -l) -gt 0 ] && $CLEAR_DATA; then
    WhiteEcho "清除挂载日志数据"
    rm -rf $LOG_DIR/*
    WhiteEcho "日志清除完毕"
fi

GreenEcho "数据文件清理-$DATA_DIR"
if [ ! -e "$DATA_DIR" ]; then
    WhiteEcho "创建数据挂载目录"
    mkdir $DATA_DIR
elif [ $(ls -A "$DATA_DIR" | wc -l) -gt 0 ]; then
    WhiteEcho "清除原挂载数据"
    rm -rf $DATA_DIR/*
    WhiteEcho "数据清理完毕"
fi

GreenEcho "容器构建-$CONTAINER_NAME"
docker run -itd \
    --name $CONTAINER_NAME \
    --restart always \
    --health-cmd="nc -zv localhost 21 || exit 1" \
    --health-interval=30s \
    --health-retries=3 \
    --health-start-period=10s \
    --health-timeout=10s \
    --user=root \
    --privileged=true \
    --network $NET_WORK \
    --ip $SERVER_IP \
    --hostname $CONTAINER_NAME \
    --publish 10020:20 \
    --publish 10021:21 \
    --publish 21100-21110:21100-21110 \
    --volume $LOG_DIR:/var/log \
    --volume $DATA_DIR:/home/vsftpd \
    --volume $CONF:/etc/vsftpd/vsftpd.conf \
    --env TZ=Asia/Shanghai \
    --env PASV_MIN_PORT=21100 \
    --env PASV_MAX_PORT=21110 \
    --env LOCAL_UMASK=022 \
    --env ANON_UMASK=022 \
    --env FTP_USER=$USER_NAME \
    --env FTP_PASS=$PASSWORD \
    --env PASV_ADDRESS=$PASV_ADDRESS \
    --workdir /home \
    $IMAGE_TAG

sleep 5
GreenEcho "容器状态"
docker ps -a -f name=$CONTAINER_NAME

sleep 3
GreenEcho "容器日志"
docker logs --tail 100 $CONTAINER_NAME

GreenEcho "容器信息"
WhiteEcho "容器Host:$CONTAINER_NAME\t容器IP:$SERVER_IP\t访问端口:10020、10021、21100-21110\t用户名:$USER_NAME\t密码:$PASSWORD"
WhiteEcho "docker exec -it -u root $CONTAINER_NAME /bin/bash"

echo -e "\n \033[34m ########## 容器 $CONTAINER_NAME 构建结束 ########## \033[0m"
