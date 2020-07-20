#!/bin/bash

echo "开始下载Nginx rpm包"

rpm -Uvh http://nginx.org/packages/centos/7/noarch/RPMS/nginx-release-centos-7-0.el7.ngx.noarch.rpm

echo "Nginx rpm包下载完成，开始安装"

yum install -y nginx

echo "安装完毕，正在为启动Nginx并设置为自启"

systemctl start nginx.service && systemctl enable nginx.service

echo "Nginx设置完成"