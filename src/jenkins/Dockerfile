FROM jenkins/jenkins:lts
# 指定自动安装插件
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt
ENTRYPOINT ["/sbin/tini", "--", "/usr/local/bin/jenkins.sh"]