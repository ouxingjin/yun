#!/bin/bash
maven="gcc openssl-devel pcre-devel"
rpm -q $maven >/dev/null
[ $? -ne 0 ] && yum -y install $maven || echo -e "\033[32m依赖包已安装\033[0m"

[ -e lnmp_soft.tar.gz ]
[ $? -ne 0 ] && tar -xf lnmp_soft.tar.gz || echo -e "\033[32mlnmp_soft.tar.gz软件包已解压\033[0m" exit

cd lnmp_soft/
[ -d nginx-1.12.2 ]
[ $? -ne 0 ] && tar nginx-1.12.2.tar.gz || echo -e "\033[32mnginx-1.12.2目录已存在\033[0m"

cd  nginx-1.12.2
./configure --prefix=/usr/local/nginx --with-http_ssl_module --with-stream --without-http_autoindex_module

make && make install 








