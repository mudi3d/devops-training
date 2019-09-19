#!/bin/bash
logfile=/tmp/script.log

echo "*** Starting script $(date +%D' '%R) ***" > ${logfile}

wget -O /tmp/sshd_config_copy https://raw.githubusercontent.com/mudi3d/devops-training/master/sshd_config
if [ $? -eq 0 ]
then
	echo "SSH config download: Done" >> ${logfile}
else
	echo "SSH config download: Fail" >> ${logfile}
fi

mv -f /tmp/sshd_config_copy /etc/ssh/sshd_config
if [ $? -eq 0 ]
then
        echo "Move and replace existing SSH config: Done" >> ${logfile}
else
        echo "Move and replace existing SSH config: Fail" >> ${logfile}
fi

systemctl restart sshd
if [ $? -eq 0 ]
then
        echo "SSH service restart: Done" >> ${logfile}
else
        echo "SSH service restart: Fail" >> ${logfile}
fi

echo "root123" | passwd --stdin root
if [ $? -eq 0 ]
then
        echo "Root password set: Done" >> ${logfile}
else
        echo "Root password set: Fail" >> ${logfile}
fi

git --version
if [ $? -eq 0 ]
then
        echo "git already installed: Bypass" >> ${logfile}
else
        yum install git -y
	git --version
	if [ $? -eq 0 ]
	then
		echo "git installation: Done" >> ${logfile}
	else
		echo "git installation: Fail" >> ${logfile}
	fi
fi

mkdir /opt/devops-training
if [ $? -eq 0 ]
then
        echo "Create git repo dir [/opt/devops-training]: Done" >> ${logfile}
else
        echo "Create git repo dir [/opt/devops-training]: Fail" >> ${logfile}
fi

cd /opt/devops-training
if [ $? -eq 0 ]
then
        echo "Change directory to [/opt/devops-training]: Done" >> ${logfile}
else
        echo "Change directory to [/opt/devops-training]: Fail" >> ${logfile}
fi

git init
if [ $? -eq 0 ]
then
        echo "git init: Done" >> ${logfile}
else
        echo "git init: Fail" >> ${logfile}
fi

git remote add origin https://github.com/mudi3d/devops-training.git
if [ $? -eq 0 ]
then
        echo "git remote add origin: Done" >> ${logfile}
else
        echo "git remote add origin: Fail" >> ${logfile}
fi

wget https://raw.githubusercontent.com/mudi3d/devops-training/master/script.sh
if [ $? -eq 0 ]
then
        echo "Download script from github: Done" >> ${logfile}
else
        echo "Download script from github: Fail" >> ${logfile}
fi

java -version
if [ $? -eq 0 ]
then
        echo "Java already installed: Bypass" >> ${logfile}
else
        yum install java -y
        java -version
        if [ $? -eq 0 ]
        then
                echo "Java installation: Done" >> ${logfile}
        else
                echo "Java installation: Fail" >> ${logfile}
        fi
fi

wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat/jenkins.repo
if [ $? -eq 0 ]
then
        echo "Download Jenkins repo: Done" >> ${logfile}
else
        echo "Download Jenkins repo: Fail" >> ${logfile}
fi

rpm --import https://pkg.jenkins.io/redhat/jenkins.io.key
if [ $? -eq 0 ]
then
        echo "Import key from Jenkins: Done" >> ${logfile}
else
        echo "Import key from Jenkins: Fail" >> ${logfile}
fi

systemctl status jenkins
if [ $? -eq 0 ]
then
        echo "Jenkins already installed: Bypass" >> ${logfile}
else
	yum install jenkins -y
	systemctl status jenkins
	if [ $? -eq 0 ]
	then
        	echo "Jenkins installation: Done" >> ${logfile}
	else
        	echo "Jenkins installation: Fail" >> ${logfile}
	fi
fi

systemctl start jenkins
if [ $? -eq 0 ]
then
        echo "Jenkins service start: Done" >> ${logfile}
else
        echo "Jenkins service start: Fail" >> ${logfile}
fi
