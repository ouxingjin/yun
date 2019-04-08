#!/bin/bash
cd soft/mongodb/
ls /usr/local/mongodb
[ $? -eq 0 ] && echo "目录已存在" || mkdir /usr/local/mongodb
[ -e mongodb-linux-x86_64-rhel70-3.6.3 ]
[ $? -eq 0 ] || tar -zxvf mongodb-linux-x86_64-rhel70-3.6.3.tgz && echo "已解包"
cp -r mongodb-linux-x86_64-rhel70-3.6.3/bin /usr/local/mongodb/ && echo "复制成功"
cd /usr/local/mongodb/
mkdird() {
        mkdir etc
        mkdir log
        mkdir -p data/db
}

network=192.168.4
ip=`ifconfig eth0 | awk -F. '/netmask/{print $4}' |awk '{print $1}'`
mkdird
mongotxt="
logpath=/usr/local/mongodb/log/mongodb.log
logappend=true 
dbpath=/usr/local/mongodb/data/db
fork=true
port=270$ip
bind_ip=$network.$ip"
for i in $mongotxt
do
        echo $i >> /usr/local/mongodb/etc/mongodb.conf
done
/usr/local/mongodb/bin/mongod -f /usr/local/mongodb/etc/mongodb.conf
alias mstop='/usr/local/mongodb/bin/mongod -f /usr/local/mongodb/etc/mongodb.conf --shutdown'
alias mstart='/usr/local/mongodb/bin/mongod -f /usr/local/mongodb/etc/mongodb.conf'
