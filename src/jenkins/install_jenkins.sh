#!/bin/bash

SERVICE_NAME=jenkins.service

read -rep "是否运行Jenkins安装脚本? (y/n)" flag

if [ "$(tr '[:upper:]' '[:lower:]' <<<"${flag:0:1}")" = "n" ]; then
  echo "exit"
  exit
fi

if ! [ -e ${SERVICE_NAME} ]; then
  echo "指定服务描述文件不存在"
  exit
fi

sudo curl -o /opt/jenkins.war \
  https://mirrors.tuna.tsinghua.edu.cn/jenkins/war-stable/latest/jenkins.war

mv -f ./${SERVICE_NAME} /etc/systemd/system/jenkins.service

sudo systemctl daemon-reload && sudo systemctl enable ${SERVICE_NAME} && systemctl start ${SERVICE_NAME}

echo "Jenkins服务已启动"