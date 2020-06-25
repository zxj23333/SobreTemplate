#!/bin/bash

FILE_PATH=./data/updates/default.json

if [ -n "$1" ] && [ -e "$1" ]; then
  FILE_PATH=$1
elif [ -n "$1" ]; then
  echo "指定的文件不存在，请重新指定"
  exit
fi

sed -i 's/http:\/\/updates.jenkins-ci.org\/download/https:\/\/mirrors.tuna.tsinghua.edu.cn\/jenkins/g' "$FILE_PATH" \
 && sed -i 's/http:\/\/www.google.com/https:\/\/www.baidu.com/g' "$FILE_PATH"

echo "请重启Jenkins，以刷新缓存"
