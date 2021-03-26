#!/bin/bash
#set -x

yum install -y httpd
systemctl enable httpd

systemctl restart httpd
systemctl stop firewalld
systemctl disable firewalld

echo "Installed httpd server."