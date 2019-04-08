#!/bin/bash

network=192.168.4

ssh-keygen -f /root/.ssh/id_rsa -N ''
nopass() {
expect << EOF
spawn ssh-copy-id  $network.$i
expect "(yes/no)?"  { send "yes\r" }                            
expect "password:" { send "1\r" }             
expect "success"          
EOF
}

for i in {50..56}
do
        nopass $i
done

