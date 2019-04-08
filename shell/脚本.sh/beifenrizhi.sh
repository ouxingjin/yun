#!/bin/bash
#每周5使用tar命令备份/var/log下的所有日志文件
#编写备份脚本，备份后的文件名包含日期标签，防止后面的备份将前面的备份数据覆盖
#要注意date命令需要用反撇号括起来
tar -zcf log-`date +%Y-%m-%d`.tar.gz /var/log

#crontab -e  编写计划任务，执行备份脚本
#00 03 *  *  5  /opt/rizhi.sh

