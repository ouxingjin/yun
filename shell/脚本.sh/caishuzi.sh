#!/bin/bash
#脚本生成一个 100 以内的随机数,提示用户猜数字,根据用户的输入,提示用户猜对了,
#猜小了或猜大了,直至用户猜对脚本结束。
#RANDOM为系统自带的系统变量，值为0-32767
#使用取余算法将随机数变为1-100的随机数
num=$[RANDOM%100+1]

#使用read提示用户猜数字
#使用if判断用户猜数大小的关系，直到猜对才结束脚本--需要使用while死循环
while :
do
    read -p "请猜一个数字（1-100）：" p
    if [ $p -eq $num ];then
        echo "恭喜，你猜对了"
        exit
    elif [ $p -gt $num ];then
        echo "抱歉，你猜大了"
    else
        echo "抱歉，你猜小了"
    fi
    sleep 1
done

