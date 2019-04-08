#!/bin/bash
#通过位置变量创建Linux系统账户和密码
#$1是执行脚本的第一个参数，$2是执行脚本的第二个参数
useradd $1
echo $2 | passwd --stdin $
