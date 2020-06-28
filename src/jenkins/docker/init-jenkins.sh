#!/bin/bash

if ! [ -e "${JENKINS_HOME}/secrets/initialAdminPassword" ]; then

  /sbin/tini -- /usr/local/bin/jenkins.sh "$@" &

  while ! [ -e "${JENKINS_HOME}/hudson.model.UpdateCenter.xml" ]; do
    sleep 1
  done

  echo "开始替换国内源"

  # shellcheck disable=SC2009
  JENKINS_PROCESS_ID=$(ps -ef | grep jenkins.war | grep -v grep | awk '{print $2}')

  echo "进程id为${JENKINS_PROCESS_ID}"

  #echo "${JENKINS_HOME}"
  sed -i 's/https:\/\/updates.jenkins.io/https:\/\/mirrors.tuna.tsinghua.edu.cn\/jenkins\/updates/g' "${JENKINS_HOME}/hudson.model.UpdateCenter.xml"

  kill -9 "${JENKINS_PROCESS_ID}"

fi

/sbin/tini -- /usr/local/bin/jenkins.sh "$@"