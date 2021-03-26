#!/bin/bash
#set -x

yum install -y httpd
systemctl enable httpd

systemctl restart httpd
systemctl disable firewalld
systemctl stop firewalld
#firewall-cmd --add-service=http --permanent
#firewall-cmd --add-service=https --permanent
#firewall-cmd daemon-reload

echo "Installed httpd server."