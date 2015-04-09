#设置继承镜像,由于官方kernel bug，使用修正过的镜像,解决了PAM的问题
FROM sequenceiq/pam:ubuntu-14.04
#作者信息
MAINTAINER hydream@gmail.com
#更改ubuntu的源为国内163的源
RUN echo "deb http://mirrors.163.com/ubuntu/ trusty main restricted universe multiverse" > /etc/apt/sources.list
RUN echo "deb http://mirrors.163.com/ubuntu/ trusty-security main restricted universe multiverse" >> /etc/apt/sources.list
RUN echo "deb http://mirrors.163.com/ubuntu/ trusty-updates main restricted universe multiverse" >> /etc/apt/sources.list
RUN echo "deb http://mirrors.163.com/ubuntu/ trusty-proposed main restricted universe multiverse" >> /etc/apt/sources.list
RUN echo "deb http://mirrors.163.com/ubuntu/ trusty-backports main restricted universe multiverse" >> /etc/apt/sources.list
RUN apt-get update

#安装 ssh 服务
RUN apt-get install -y openssh-server
RUN mkdir -p /var/run/sshd
RUN mkdir -p /root/.ssh

#修改ROOT密码
RUN echo 'root:password@02' | chpasswd

#开启ROOT SSH登陆
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

#取消pam限制
#RUN sed -ri 's/session    required     pam_loginuid.so/#session    required     pam_loginuid.so/g' /etc/pam.d/sshd

# SSH 登陆修复，否者用户在登陆后被踢
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

#复制配置文件到相应位置
ADD authorized_keys /root/.ssh/authorized_keys

#ENV NOTVISIBLE "in users profile"
#RUN echo "export VISIBLE=now" >> /etc/profile

#开放端口
EXPOSE 22

#设置自启动命令,启动SSH服务
CMD ["/usr/sbin/sshd", "-D"]