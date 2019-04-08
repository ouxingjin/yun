#!/bin/bash
#需要有soft.tar.gz压缩包
ip=`ifconfig eth0 | awk -F. '/netmask/{print $4}' |awk '{print $1}'`
rpm -q gcc >/dev/null
[ $? -eq 0 ] && echo "依赖包gcc已安装" || yum -y install gcc
cd /root/soft/redis
ls redis-4.0.8
if [ $? -eq 0 ];then
  cd redis-4.0.8
else
   tar -zxvf redis-4.0.8.tar.gz
   cd redis-4.0.8
   make
   make install
fi
sed -i "s/6379/63${ip}/" ./utils/install_server.sh
echo | ./utils/install_server.sh  && echo -e "\033[32mchushihuachenggong\033[0m "
redis-cli -h 127.0.0.1 -p  63${ip} shutdown >/dev/null
sed -i "s/^bind 127.0.0.1/bind 192.168.4.${ip}/" /etc/redis/63${ip}.conf
sed -i "s/\$CLIEXEC -p \$REDISPORT shutdown/\$CLIEXEC -h 192.168.4.${ip} -p 63${ip} shutdown/" /etc/init.d/redis_63${ip}
/etc/init.d/redis_63${ip} start

