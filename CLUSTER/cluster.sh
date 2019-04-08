#!/bin/bash


#给node1添加yum源
rm -rf /etc/yum.repos.d/*.repo
echo "
[rhel]
name=rhel7.4
baseurl=ftp://192.168.4.254/rhel7
enabled=1
gpgcheck=0

[mon]
name=mon
baseurl=ftp://192.168.4.254/ceph/rhceph-2.0-rhel-7-x86_64/MON
gpgcheck=0
[osd]
name=osd
baseurl=ftp://192.168.4.254/ceph/rhceph-2.0-rhel-7-x86_64/OSD
gpgcheck=0
[tools]
name=tools
baseurl=ftp://192.168.4.254/ceph/rhceph-2.0-rhel-7-x86_64/Tools
gpgcheck=0
" >/etc/yum.repos.d/ceph.repo

#修改/etc/hosts并同步到所有主机
echo "
192.168.4.5 node4 
192.168.4.6 node5
192.168.4.7 node6
192.168.4.8 node7
" >/etc/hosts

#创建密钥，并将公钥传给远程的主机，实现无密码登陆
ssh-keygen -f /root/.ssh/id_rsa -N ''
for i in 5 6 7 8
do 
ssh-copy-id 192.168.4.$i  #第一次远程会出现（yes/no）、以及要输入密码：
done 

for i in node4 node5 node6 node7
do 
ssh-copy-id $i  #第一次远程会出现（yes/no）、以及要输入密码：
done 

for i in 5 7 8
do 
scp /etc/yum.repos.d/ceph.repo 192.168.4.$i:/etc/yum.repos.d/
done

for i in 5 6 7 8
do 
ssh 192.168.4.$i "yum clean all;yum repolist;sleep 1"
done

#将修改了域名解析的/etc/hosts文件传给远程主机
for i in 5 6 7 8
do 
scp /etc/hosts 192.168.4.$i:/etc/
done

#修改时间同步文件，指定服务器
sed -i 's/server/#server/g' /etc/chrony.conf
sed -i '3a server 192.168.4.254 iburst' /etc/chrony.conf

#将/etc/chrony.conf文件传给远程主机，实现主机间NTP时间同步
for i in 5 6 7 8 
do
scp /etc/chrony.conf 192.168.4.$i:/etc/
done
#远程主机，开启时间同步服务
for i in 5 6 7 8
do
ssh 192.168.4.$i "systemctl restart chronyd;sleep 5"
done

########################################################
#2.部署ceph集群 ，要事先给主机添加3快硬盘,
yum -y install ceph-deploy  #安装部署工具ceph-deploy脚本

#2）创建ceph的工作目录
mkdir ceph-cluster
cd ceph-cluster/

#创建ceph集群配置
ceph-deploy new node5 node6 node7
#3）给所有节点安装软件包。
ceph-deploy install  node4 node5 node6 node7 ; sleep 3
#4）初始化所有节点的mon服务（主机名解析必须对）
ceph-deploy mon create-initial ; sleep 3

#------------创建OSD
#将远程主机/dev/vdb磁盘划分为两个分区
for i in  6 7 8
do
ssh 192.168.4.$i "parted /dev/vdb mklabel gpt;parted /dev/vdb mkpart primary 1M 50%;sleep 2;parted /dev/vdb mkpart primary 50% 100%;sleep 2"
done

for i in  6 7 8
do
ssh 192.168.4.$i "chown ceph.ceph /dev/vdb1;chown ceph.ceph /dev/vdb2"
done
#修改udev规则
echo "
ENV{DEVNAME}=="/dev/vdb1",OWNER="ceph",GROUP="ceph"
ENV{DEVNAME}=="/dev/vdb2",OWNER="ceph",GROUP="ceph"
" >/etc/udev/rules.d/70-vdb.rules

for i in 6 7 8
do
scp /etc/udev/rules.d/70-vdb.rules 192.168.4.$i:/etc/udev/rules.d/
done

#初始化清空磁盘数据
ceph-deploy disk  zap node5:vdc node5:vdd ; sleep 3
ceph-deploy disk  zap node6:vdc node6:vdd ; sleep 3
ceph-deploy disk  zap node7:vdc node7:vdd ; sleep 3

#创建OSD存储空间
ceph-deploy osd create node5:vdc:/dev/vdb1 node5:vdd:/dev/vdb2
sleep 1
ceph-deploy osd create node6:vdc:/dev/vdb1 node6:vdd:/dev/vdb2
sleep 1
ceph-deploy osd create node7:vdc:/dev/vdb1 node7:vdd:/dev/vdb2

#1) 查看集群状态
ceph  -s












