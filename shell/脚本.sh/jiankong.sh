#!/bin/bash
#实时监控本机内存和硬盘剩余空间,剩余内存小于 500M、根分区剩余空间小于 1000M
#,发送报警邮件给 root 管理员

#提取根分区剩余空间
disk_size=$(df / |awk '/\//{print $4}')

#提取内存剩余空间
mem_size=`free |awk '/Mem/{print $4}'`

#要想实现实时监控，需要使用while死循环
while :
do
#注意内存和磁盘提取的空间大小都是一Kb为单位
  if [ $disk_size  -le  512000  -a  $mem_size  -le  1024000 ];then
        mail -s "warning" root <<EOF
        Insufficient resources,资源不足
EOF
#<<EOF ...EOF 给邮件定义内容，EOF需要顶格
  fi
  sleep 1
done

