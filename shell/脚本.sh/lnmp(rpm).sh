#!/bin/bash
#一键部署LNMP（RPM包版）
yum -y install httpd
yum -y install mariadb mariadb-servre mariadb-devel
yum -y install php php-mysql

systemctl restart httpd mariadb
systemctl enable httpd mariadb

