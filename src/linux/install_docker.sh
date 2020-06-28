#!/bin/bash

# 依赖列表
DOCKER_DEPEND_LIST=("yum-utils" "device-mapper-persistent-data" "lvm2")

DOCKER_NAME="docker-ce"

read -rep "是否开始运行${DOCKER_NAME}安装脚本? (y/n): " flag

if [ "$(tr '[:upper:]' '[:lower:]' <<<"${flag:0:1}")" = "n" ]; then
  echo "exit"
  exit
fi

for depend in "${DOCKER_DEPEND_LIST[@]}"; do
  yum install -y "${depend}"
done

yum-config-manager --add-repo https://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo &&
  yum makecache fast

yum install -y docker-ce

echo "${DOCKER_NAME}安装完成，设置镜像源"

CONFIG_FILE=/etc/docker/daemon.json

if ! [ -e "${CONFIG_FILE}" ]; then
  mkdir "/etc/docker"
fi
echo '{"registry-mirrors": ["https://83tnzmjf.mirror.aliyuncs.com"]}' >>"${CONFIG_FILE}"
systemctl daemon-reload && systemctl restart docker && systemctl enable docker

echo "Docker设置完毕"

DOCKER_COMPOSE_VERSION=1.26.0
DOCKER_COMPOSE_PATH=/usr/local/bin/docker-compose

read -rep "是否需要安装Docker-Compose? (y/n): " flag

if [ "$(tr '[:upper:]' '[:lower:]' <<<"${flag:0:1}")" = "n" ]; then
  echo "exit"
  exit
fi

read -rep "请输入Docker-Compose的版本号(默认为${DOCKER_COMPOSE_VERSION})" version

if [ -n "${version}" ]; then
  DOCKER_COMPOSE_VERSION=version
fi

curl -L "https://get.daocloud.io/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o ${DOCKER_COMPOSE_PATH} \
  && chmod +x ${DOCKER_COMPOSE_PATH}
