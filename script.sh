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

git config --global user.name "mudi3d"
if [ $? -eq 0 ]
then
	echo "git config set username: Done" >> ${logfile}
else
	echo "git config username: Fail" >> ${logfile}
fi

git config --global user.email "mscdjkingrock@gmail.com"
if [ $? -eq 0 ]
then
	echo "git config email: Done" >> ${logfile}
else
	echo "git config email: Fail" >> ${logfile}
fi

cd /opt
ls -l /opt/devops-training
if [ $? -eq 0 ]
then
	echo "git repository already there: Bypass" >> ${logfile}
else
	git clone https://github.com/mudi3d/devops-training.git
	ls -l /opt/devops-training
	if [ $? -eq 0 ]
        then
                echo "git clone: Done" >> ${logfile}
        else
                echo "git clone: Fail" >> ${logfile}
        fi
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

wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
if [ $? -eq 0 ]
then
        echo "Download Jenkins repo: Done" >> ${logfile}
else
        echo "Download Jenkins repo: Fail" >> ${logfile}
fi

rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
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
