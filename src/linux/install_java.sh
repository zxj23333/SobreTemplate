#!/bin/bash

jdk_path="/opt/"
jdk_tar_name=$(find . -maxdepth 1 -type f -name "jdk*.tar.gz")

echo "正在提取Java安装包，安装包名为${jdk_tar_name}"

tar -zxf "${jdk_tar_name}" -C ${jdk_path}

jdk_path=$(find ${jdk_path} -maxdepth 1 -type d -name "jdk*")

echo "Java安装目录为${jdk_path}"

# 配置环境变量
# shellcheck disable=SC2016
echo "export JAVA_HOME=${jdk_path}" >> /etc/profile && echo 'export PATH=$PATH:$JAVA_HOME/bin' >> /etc/profile

echo "Java环境配置成功，请手动执行source /etc/profile刷新配置"
