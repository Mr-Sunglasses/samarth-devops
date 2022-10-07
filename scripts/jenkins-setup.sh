#!/bin/bash
bold=$(tput bold)
normal=$(tput sgr0)

echo -e "\n\e[0;32m${bold}Updating the apt repo${normal}\n"
apt-get update

echo -e "\n\e[0;32m${bold}Installating Java${normal}\n"
sudo apt install default-jre -y
sudo apt install default-jdk -y
javac -version
java -version

echo -e "\n\e[0;32m${bold}Installating Jenkins${normal}"
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt update
sudo apt install jenkins -y

echo -e "\n\e[0;32m${bold}Installating PIP${normal}"
apt-get install -y python3-pip

echo -e "\n\e[0;32m${bold}Installating Git ${normal}"
apt-get install -y git

echo -e "\n\e[0;32m${bold}Installating Docker${normal}"
apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
apt-get update
apt-get install -y docker-ce docker-ce-cli containerd.io

echo -e "\n\e[0;32m${bold}Installating Ansible${normal}"
pip3 install ansible 

echo -e "\n\e[0;32m${bold}Installating pip docker${normal}"
pip3 install docker

echo -e "\n\e[0;32m${bold}Adding jenkins user to docker group${normal}"
usermod -aG docker jenkins

echo -e "\n\e[0;32m${bold}Creating bashrc for jenkins user ${normal}"
cp /etc/skel/.bashrc /var/lib/jenkins
chown jenkins:jenkins /var/lib/jenkins/.bashrc

echo -e "\n\e[0;32m${bold}Setting timezone to IST ${normal}"
timedatectl set-timezone Asia/Kolkata

echo -e "\n\e[0;32m${bold}Clean up${normal}"
sudo apt -y autoremove

echo -e "\n\e[0;32m${bold}Installation complete. Please go to your jenkins URL and continue setup if this is the first run..${normal}"
echo "chmod +x jenkins -o -b "fixing" --precache==True "
