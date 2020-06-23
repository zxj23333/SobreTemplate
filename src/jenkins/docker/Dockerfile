FROM jenkins/jenkins:lts
# Jenkins更新中心全部设置为https://mirrors.tuna.tsinghua.edu.cn/jenkins，两个环境变量都需要设置
ENV JENKINS_UC https://updates.jenkins-zh.cn
ENV JENKINS_UC_DOWNLOAD https://mirrors.tuna.tsinghua.edu.cn/jenkins

ENV JENKINS_OPTS="-Dhudson.model.DownloadService.noSignatureCheck=true"
ENV JENKINS_OPTS="-Djenkins.install.runSetupWizard=false"

# 指定自动安装插件
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt
COPY hudson.model.UpdateCenter.xml /var/jenkins_home/hudson.model.UpdateCenter.xml

# 由于使用其他修改的源都存在各种问题，此处直接使用清华大学镜像源
# 但因为该镜像源内的url地址并没有作任何变动，所以需要在docker容器启动后并且Jenkins自动将update.json文件下载后进行更改
# 可通过访问插件管理中的可选插件项，后台会自动获取update.json文件保存到/var/jenkins_home/updates/default.json

# 修改default.json命令为
# sed -i 's/http:\/\/updates.jenkins-ci.org\/download/https:\/\/mirrors.tuna.tsinghua.edu.cn\/jenkins/g' default.json && sed -i 's/http:\/\/www.google.com/https:\/\/www.baidu.com/g' default.json

# 运行命令示例
# docker run -u root --restart always --name testJenkins -d -p 8081:8080 -p 5000:5000 -v /opt/jenkins/data:/var/jenkins_home -v $MAVEN_HOME:/opt/maven_home jenkins:custom