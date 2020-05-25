FROM redis
COPY redis6.0.conf /usr/local/etc/redis/redis.conf
CMD [ "redis-server", "/usr/local/etc/redis/redis.conf" ]

# 启动命令实例
# docker run --restart=always -p {port}:6379 -v {dir}:/data -d --name {containerName} redis:custom