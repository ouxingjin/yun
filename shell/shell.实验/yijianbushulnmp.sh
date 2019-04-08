#!/bin/bash
maven="gcc openssl-devel pcre-devel"
maria="mariadb mariadb-server mariadb-devel"


color() {
echo -e "\033[$1m$2\033[0m"
}
while :
do
color 33 '##############################################################
######## 1.Install gcc,openssl-devel pcre-devel  #############
######## 2.Install mariadb mariadb-server mariadb-devel ######
######## 3.Install php php-mysql php-fpm######################
######## 4.Systemctl restart #################################
######## 5.Install nginx #####################################
######## Q.exit  #############################################
##############################################################'
#n=`color 33 'Please inter your choice[1-Q]:'`
read -p "`color 33 'Please inter your choice[1-Q]:'`" p

case $p in
1)
  rpm -q $maven >/dev/null
  [ $? -ne 0 ] && yum -y install $maven || echo -e "\033[32m依赖包已安装\033[0m"
  clear
  sleep 2
  continue;;
2)
   rpm -q $maria >/dev/null
   [ $? -ne 0 ] && yum -y install $maria || echo -e "\033[32m数据库相关包已安装\033[0m"
  sleep 3
  clear
  continue ;;
3)
  yum -y install php php-mysql
  cd /root/lnmp_soft/
  yum -y install php-fpm-5.4.16-42.el7.x86_64.rpm
  sleep 3
  clear ;;
4)
   clear
  systemctl start mariadb php-fpm
  systemctl enable mariadb php-fpm
  sleep 3
  continue ;;
5)
    [ -e lnmp_soft.tar.gz ]
    [ $? -eq 0 ] && tar -xf lnmp_soft.tar.gz || echo -e "\033[32mlnmp_soft.tar.gz软件包已解压\033[0m" exit

   cd lnmp_soft/
   [ -d nginx-1.12.2 ]
   [ $? -ne 0 ] && tar -xf nginx-1.12.2.tar.gz || echo -e "\033[32mnginx-1.12.2目录已存在\033[0m"

   cd nginx-1.12.2
   ./configure --with-http_ssl_module --with-stream --with-http_stub_status_module --without-http_autoindex_module
   make && make install
   ln -s /usr/local/nginx/sbin/nginx /usr/sbin/
   cd .. ;;
Q|q)
   clear
  exit ;;
 esac

done


