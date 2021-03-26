#!/bin/bash
#set -x

sudo yum install -y httpd
sudo systemctl enable httpd

sudo systemctl start httpd
sudo firewall-cmd --permanent --add-port=80/tcp

sudo firewall-cmd --permanent --add-port=443/tcp
sudo firewall-cmd --reload

echo "Installed httpd server."