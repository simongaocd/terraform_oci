#!/bin/bash
#set -x

sudo yum install -y httpd
sudo systemctl enable httpd

sudo systemctl restart httpd
sudo systemctl disable firewalld
sudo systemctl stop firewalld
#sudo firewall-cmd --add-service=http --permanent

#sudo firewall-cmd --add-service=https --permanent
#sudo firewall-cmd --reload

echo "Installed httpd server."