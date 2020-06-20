FROM jenkins/jenkins:lts
# Jenkins更新中心全部设置为https://mirrors.tuna.tsinghua.edu.cn/jenkins，两个环境变量都需要设置
ENV JENKINS_UC https://mirrors.tuna.tsinghua.edu.cn/jenkins
ENV JENKINS_UC_DOWNLOAD https://mirrors.tuna.tsinghua.edu.cn/jenkins
# 指定自动安装插件
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt
COPY hudson.model.UpdateCenter.xml /var/jenkins_home/hudson.model.UpdateCenter.xml

# 运行命令示例
# docker run --restart always --name testJenkins -d -p 8081:8080 -p 5000:5000 jenkins:custom