#install ansible、ssh、docker
#ROOT login,Need conn internet
#OS:Ubuntu 14.04.2 LTS
#ansible 1.9.0.1
#Docker version 1.0.1, build 990021a

#install ansible
echo "install ansible, please wait!!"
sudo apt-get install python-pip python-dev build-essential git
sudo pip install ansible
mkdir  /etc/ansible/
#echo "192.168.0.90">>/etc/ansible/hosts

#install SSH
echo "install SSH, please wait!!"
sudo apt-get install openssh-server
sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

#install docker
echo "install docker, please wait!!"
sudo apt-get docker.io

#docker run -d -p 22 -p 8081:8080 --name="web" tomcat:8-jre8 /usr/sbin/sshd -D

#run three container
echo "run three container"
docker run -d -p 22 -p 8081:8080 --name="web"  hydream/ssh:3.0
docker run -d -p 22 -p 8082:8080 --name="app"   hydream/ssh:3.0
docker run -d -p 22 -p 8083:8080 --name="prevayler"   hydream/ssh:3.0

#get ip of three container
docker inspect web|grep -i address
docker inspect app|grep -i address
docker inspect prevayler|grep -i address
echo "this three ip is very import! Please write down"


