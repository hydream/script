#���ü̳о���,���ڹٷ�kernel bug��ʹ���������ľ���,�����PAM������
FROM sequenceiq/pam:ubuntu-14.04
#������Ϣ
MAINTAINER hydream@gmail.com
#����ubuntu��ԴΪ����163��Դ
RUN echo "deb http://mirrors.163.com/ubuntu/ trusty main restricted universe multiverse" > /etc/apt/sources.list
RUN echo "deb http://mirrors.163.com/ubuntu/ trusty-security main restricted universe multiverse" >> /etc/apt/sources.list
RUN echo "deb http://mirrors.163.com/ubuntu/ trusty-updates main restricted universe multiverse" >> /etc/apt/sources.list
RUN echo "deb http://mirrors.163.com/ubuntu/ trusty-proposed main restricted universe multiverse" >> /etc/apt/sources.list
RUN echo "deb http://mirrors.163.com/ubuntu/ trusty-backports main restricted universe multiverse" >> /etc/apt/sources.list
RUN apt-get update

#��װ ssh ����
RUN apt-get install -y openssh-server
RUN mkdir -p /var/run/sshd
RUN mkdir -p /root/.ssh

#�޸�ROOT����
RUN echo 'root:password@02' | chpasswd

#����ROOT SSH��½
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

#ȡ��pam����
#RUN sed -ri 's/session    required     pam_loginuid.so/#session    required     pam_loginuid.so/g' /etc/pam.d/sshd

# SSH ��½�޸��������û��ڵ�½����
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

#���������ļ�����Ӧλ��
ADD authorized_keys /root/.ssh/authorized_keys

#ENV NOTVISIBLE "in users profile"
#RUN echo "export VISIBLE=now" >> /etc/profile

#���Ŷ˿�
EXPOSE 22

#��������������,����SSH����
CMD ["/usr/sbin/sshd", "-D"]