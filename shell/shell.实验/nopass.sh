#!/bin/bash
network=192.168.2
nopass() {
#ssh-keygen -f /root/.ssh/id_rsa6 -N ''

expect << EOF
spawn ssh-copy-id $network.$i
expect "(yes/no)"  { send "yes\r" }                            
expect "password:" { send "1\r" }             
expect "success"          
EOF
}


main() {
 	nopass
}

for i in 5 100 200
do 
	main $i 
done
