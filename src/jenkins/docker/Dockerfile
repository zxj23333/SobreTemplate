FROM jenkins/jenkins:lts
# Jenkins更新中心全部设置为https://mirrors.tuna.tsinghua.edu.cn/jenkins，两个环境变量都需要设置
ENV JENKINS_UC https://updates.jenkins-zh.cn
ENV JENKINS_UC_DOWNLOAD https://mirrors.tuna.tsinghua.edu.cn/jenkins

ENV JENKINS_OPTS="-Dhudson.model.DownloadService.noSignatureCheck=true"
ENV JENKINS_OPTS="-Djenkins.install.runSetupWizard=false"

# 指定自动安装插件
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt

# 配置maven
COPY --from=maven:3.6.3-jdk-8 /usr/share/maven /opt/maven
ENV MAVEN_HOME /opt/maven
ENV PATH="${MAVEN_HOME}/bin:${PATH}"
COPY settings.xml ${MAVEN_HOME}/conf/settings.xml

COPY init-jenkins.sh /usr/local/bin/init-jenkins.sh
ENTRYPOINT ["init-jenkins.sh"]

# 运行命令示例
# docker run -u root --restart always --name testJenkins -d -p 8081:8080 -p 5000:5000 -v /opt/jenkins/data:/var/jenkins_home jenkins:custom