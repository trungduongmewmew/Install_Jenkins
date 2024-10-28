#!/bin/bash
# Author: DuongDT
set -x
#Add the following hostname entry in /etc/hosts file
echo "10.10.11.145   jenkins.mylabpoc.local" | sudo tee -a /etc/hosts
sudo dnf update -y
sudo dnf install wget -y
#Add Jenkins Package Repository
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
# Install Jenkins on RHEL 9/8 with dnf command
sudo  dnf install -y fontconfig java-17-openjdk
java --version

sudo dnf install jenkins -y
# Start and Enable Jenkins Service via systemctl
sudo systemctl start jenkins
sudo systemctl enable jenkins
sudo systemctl status jenkins
#Configure Firewall Rules for Jenkins  
sudo firewall-cmd --permanent --add-port=8080/tcp
sudo firewall-cmd --reload
#show the password for user admin
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
set +x
