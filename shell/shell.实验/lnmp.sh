#!/bin/bash
#yum clean all
#ip=`ifconfig eth0 | awk -F. '/netmask/{print $4}' |awk '{print $1}'`

 
bao="gcc openssl-devel pcre-devel"
rpm -ql $bao
if [ $? -ne 0 ];then
   yum -y install $bao >/dev/null
fi
 
tar -xf lnmp_soft.tar.gz
 [ $? -ne 0 ] && exit
 
cd /root/lnmp_soft/
tar -xf nginx-1.12*
cd nginx-1.12.2
useradd -s /sbin/nologin nginx
./configure --user=nginx --group=nginx --with-http_ssl_module --with-stream --with-http_stub_status_module
make && make install
systemctl stop httpd >/dev/null
/usr/local/nginx/sbin/nginx &> /dev/null
ln -s /usr/local/nginx/sbin/nginx /sbin/
nginx -V && sleep 5
#firefox 127.0.0.1 && sleep 3
 
m="mariadb mariadb-server mariadb-devel"
rpm -ql $m
if [ $? -ne 0 ];then
   yum -y install $m
fi
 
n="php php-mysql php-fpm"
rpm -ql $n
if [ $? -ne 0 ];then
  yum -y install $n
fi
 
cd /root/lnmp_soft
  yum -y install php-fpm-5.4.16-42.el7.x86_64.rpm
 
systemctl restart mariadb
systemctl restart php-fpm
systemctl enable mariadb
systemctl enable php-fpm

