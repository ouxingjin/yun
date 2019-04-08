#!/bin/bash
#检测本机当前用户是否为超级管理员,如果是管理员,则使用 yum 安装 vsftpd,如果不
#是,则提示您非管理员(一是使用字串对比版本) 二是判断$UID是否等于0
if [ $USER == "root" ];then
        yum -y install vsftpd
else
        echo "您不是管理员,没有权限安装软件"
fi

