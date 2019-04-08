#!/bin/bash
#一键自动开启新终端,远程多台虚拟主机
gnome-terminal --window -e "ssh -X 192.168.4.50"  --tab -e "ssh -X 192.168.4.51" --tab -e "ssh -X 192.168.4.52" --tab -e "ssh -X 192.168.4.53" --tab -e "ssh -X 192.168.4.54" --tab -e "ssh -X 192.168.4.55" --tab -e "ssh -X 192.168.4.56" --tab -e "ssh -X 192.168.4.57" --tab -e "ssh -X 192.168.4.58" 
