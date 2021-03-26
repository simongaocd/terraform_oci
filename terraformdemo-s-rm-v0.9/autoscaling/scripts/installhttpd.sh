#!/bin/bash
#set -x

sudo yum install -y httpd
sudo systemctl enable httpd

sudo systemctl restart httpd
sudo systemctl disable firewalld
sudo systemctl stop firewalld

echo "Installed httpd server."