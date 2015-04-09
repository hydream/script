#github git Playbook, use for install tomcat
cd /etc/ansible/
rm -rf /etc/ansible/TomcatPlaybook
cd /etc/ansible/
git clone https://github.com/hydream/TomcatPlaybook

#run Playbook
cd /etc/ansible/TomcatPlaybook
ansible-playbook -i hosts site.yml

#------------------------------------------------------------------------------------------------------------------------------
#Github git test file or get file from local CI, use ansible publish to muti servers
#echo "Github git test file or get file from local CI, use ansible publish to muti servers"
echo -e "\033[31m Github git test file or get file from local CI, use ansible publish to muti servers \033[0m"

cd /tmp
rm -rf /tmp/test
git clone https://github.com/hydream/test
cd /etc/ansible/TomcatPlaybook
ansible -i hosts -m copy -a 'src=/tmp/test dest=/usr/share/tomcat/webapps force=yes'
