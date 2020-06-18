#!/bin/bash

# 依赖列表
DOCKER_DEPEND_LIST=("yum-utils" "device-mapper-persistent-data" "lvm2")

SOFTWARE_NAME="docker-ce"

read -rep "是否开始运行${SOFTWARE_NAME}安装脚本? (y/n): " flag

if [ "$(tr '[:upper:]' '[:lower:]' <<<"${flag:0:1}")" = "n" ]; then
  echo "exit"
  exit
fi

for depend in "${DOCKER_DEPEND_LIST[@]}" ; do
    yum install -y "${depend}"
done

yum-config-manager --add-repo https://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo \
  && yum makecache fast

yum install -y docker-ce

echo "${SOFTWARE_NAME}安装完成，设置镜像源"

CONFIG_FILE=/etc/docker/daemon.json

if ! [ -e "${CONFIG_FILE}" ]; then
  mkdir "/etc/docker"
fi
echo '{"registry-mirrors": ["https://83tnzmjf.mirror.aliyuncs.com"]}' >>"${CONFIG_FILE}"
systemctl daemon-reload && systemctl restart docker && systemctl enable docker

echo "设置完毕"