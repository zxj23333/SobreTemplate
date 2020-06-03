#!/bin/bash

# 定义必装软件列表
MUST_SOFTWARE_LIST=("bash-completion" "net-tools.x86_64" "wget" "vim")

# 定义选装软件列表
OPTIONAL_SOFTWARE_LIST=("docker")

echo "Centos最小安装原型预准备脚本，安装列表如下:"
for ((i = 0; i < "${#MUST_SOFTWARE_LIST[@]}"; i++)); do
  echo "$((i + 1)). ${MUST_SOFTWARE_LIST[${i}]}"
done
echo "已安装软件将跳过安装，不会进行更新操作"

read -rep "是否开始运行脚本? (y/n): " flag

function install() {
  for name in "$@"
  do
    echo "开始安装${name}..."
    yum install -y "$name"
    echo "${name}安装完成"
  done
}

function softwareExist() {
  return "$(rpm -qa "$1" | wc -l)"
}

# 判断是否运行脚本
if [ "$(tr '[:upper:]' '[:lower:]' <<<"${flag:0:1}")" = "n" ]; then
  echo "exit"
  exit
fi

# 更换yum源
read -rep "是否更换为国内yum源? (y/n): " flag

if [ "$(tr '[:upper:]' '[:lower:]' <<<"${flag:0:1}")" = "y" ]; then
  BACKUP="/etc/yum.repos.d/CentOS-Base.repo.backup"
  echo "备份原yum源，备份文件为${BACKUP}"
  mv /etc/yum.repos.d/CentOS-Base.repo ${BACKUP}
  #curl -o /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo && yum makecache
  curl -o /etc/yum.repos.d/CentOS-Base.repo http://mirrors.163.com/.help/CentOS7-Base-163.repo && yum makecache
fi

for software in "${MUST_SOFTWARE_LIST[@]}"; do
  if softwareExist "${software}"; then
    install "${software}"
  fi
done

# 是否关闭防护墙
read -rep "是否永久关闭防火墙? (y/n): " flag

if [ "$(tr '[:upper:]' '[:lower:]' <<<"${flag:0:1}")" = "y" ]; then
  systemctl stop firewalld && systemctl disable firewalld
fi

# 是否安装docker
for software in "${OPTIONAL_SOFTWARE_LIST[@]}"; do
  read -rep "可选操作:是否需要安装${software}? (y/n): " flag
  if ([ "$(tr '[:upper:]' '[:lower:]' <<<"${flag:0:1}")" = "y" ] && softwareExist "${software}"); then
    case "${software}" in
    "docker")
      install "yum-utils" "device-mapper-persistent-data" "lvm2"
      yum-config-manager --add-repo https://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
      yum makecache fast && install docker-ce
      ;;
    *) install "${software}" ;;
    esac
  fi
done
