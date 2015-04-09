#vi ansible hosts
rm -rf /etc/ansible/TomcatPlaybook
vi /etc/ansible/TomcatPlaybook/hosts

#github git Playbook, use for install tomcat

cd /etc/ansible/
git clone https://github.com/hydream/TomcatPlaybook
