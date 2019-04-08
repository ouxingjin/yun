#!/bin/bash

#解包
mysql_tar() {
    [ -e mysql-5.7.17.tar ]
 if [ $? -eq 0 ];then
	tar -xf mysql-5.7.17.tar
	return 0
 else
	echo "mysql tar包不存在"
	return 1
 fi
}
   mysql_tar
###############################################
#安装mysql软件包
mysql_server() {
	ls mysql-community*
	if [ $? -eq 0 ];then
	     	yum -y install  mysql-community* 
		systemctl start mysqld && systemctl enable mysqld
		return 0		
	else
		echo "没有mysql安装包"
	fi
}
	mysql_server

################################################
#提取mysql初始登陆密码：
#      pass=`grep 'temporary password' /var/log/mysqld.log | awk '{print $11}'`
#管理员登陆mysql数据库：
#	mysql -uroot -p$pass
#修改数据库密码：
#	set global validate_password_policy=0;
#	set global validate_password_length=6;
#	alter user user() identified by "123456";
#	quit




















