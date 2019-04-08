#!/bin/bash
#配置yum源
adyum() {
        yum="[rhel]
        name=rhel7.4
        baseurl=ftp://192.168.4.254/rhel7
        enabled=1
        gpgcheck=0"
for j in $yum
do
      ssh  $network.$i "echo $j >> /etc/yum.repos.d/rhel.repo"
done
}

#配置永久ip
network=192.168.4
ipadd() {
        ssh $1 "nmcli connection modify eth0 ipv4.method manual ipv4.addresses $1/24 connection.autoconnect yes"
        ssh $1 "nmcli connection up eth0"
	  ssh $1 "echo "DBA-$i" > /etc/hostname  "
}

#配置免密
nopass() {
#rm -rf /root/.ssh/known_hosts/*
#ssh-keygen -f /root/.ssh/id_rsa -N ''

expect << EOF
spawn ssh-copy-id -o StrictHostKeyChecking=no $network.$i
#expect "(yes/no)?"  { send "yes\r" }                            
expect "password:" { send "123456\r" }             
expect "success"          
EOF
}

main() {
	nopass
	ipadd $network.$i 
	adyum $network.$i

}


for i in {53..55}
do
	main $i 
done










