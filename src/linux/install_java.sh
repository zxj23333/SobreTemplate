#!/bin/bash

jdk_path="/opt/"
jdk_tar_name=$(find . -maxdepth 1 -type f -name "jdk*.tar.gz")

if ! [ "$jdk_tar_name" ]; then
    echo "没有找到可用的Java安装包，请将指定的安装包放在同级目录下。安装包名为jdk{version}.tar.gz"
    exit
fi

echo "正在提取Java安装包，安装包名为${jdk_tar_name}"

tar -zxf "${jdk_tar_name}" -C ${jdk_path}

jdk_path=$(find ${jdk_path} -maxdepth 1 -type d -name "jdk*")

echo "Java安装目录为${jdk_path}"

# 配置环境变量
# shellcheck disable=SC2016
echo "export JAVA_HOME=${jdk_path}" >> /etc/profile && echo 'export PATH=$PATH:$JAVA_HOME/bin' >> /etc/profile

echo "Java开发环境配置成功，请手动执行source /etc/profile刷新配置"

read -rep "是否需要安装Maven? (y/n): " flag

# 判断是否运行脚本
if [ "$(tr '[:upper:]' '[:lower:]' <<<"${flag:0:1}")" = "n" ]; then
  echo "exit"
  exit
fi

maven_path="/opt/apache-maven-3.6.3"
maven_tar_name="${maven_path}.tar.gz"

echo "正在下载maven安装包，安装包为${maven_path}"
curl -o "${maven_tar_name}" https://mirrors.bfsu.edu.cn/apache/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz

tar -zxf "${maven_tar_name}" -C "/opt"

echo "export MAVEN_HOME=${maven_path}" >> /etc/profile && echo 'export PATH=$PATH:$MAVEN_HOME/bin' >> /ect/profile

echo "maven环境变量已配置，请手动执行source /etc/profile刷新配置"
echo "maven安装完成，请前往安装目录中的conf目录下修改setting.xml配置"
