FROM mysql:5.7.30
COPY my.cnf /etc/mysql/conf.d/my.cnf
ENV MYSQL_ROOT_PASSWORD zxj19991213
# docker下的mysql默认情况下root用户可以直接远程连接
CMD ["mysqld"]

# 启动命令实例
# docker run --restart=always --name {containerName} -v {dataDir}:/var/lib/mysql -p {port}:3306 -d mysql:custom