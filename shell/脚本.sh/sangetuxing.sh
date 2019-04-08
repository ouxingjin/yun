#!/bin/bash
#for(())为类c语言的语法格式，也可以使用for i in；do ；done格式替换
#for(( i=1;i<=9;i++))循环会执行9次，i从1开始到9，每循环一次i自加1
#clear 
#    for (( i=1; i<=9; i++ ))
#    do
#        for (( j=1; j<=i; j++))
#          do
#           echo -n "$i"
#         done
#        echo ""
#    done
#   read -n1 "按任意键继续" key
# echo -n 不换行输出
clear
for i in `seq 9`
do
   for j in `seq $i`
   do
      echo -n "$i"
   done
  echo ""  #每循环一次换行输出空格
done
   read -n1 "按任意键继续" key
###########################################################
clear
for i in `seq 5`
do
    for j in `seq $i`
    do
        echo -n " |"
    done
    echo "_"
done
   read -n1 "按任意键继续" key

##############################################################
clear
for i in `seq 1 10`
do
    for j in `seq $i`
    do
      echo  -n  " *"
    done
   echo ""
done

for  (( i=10; i>=1; i-- ))
do
     for (( j=1; j<=i; j++ ))
     do
        echo -n " *"
     done
   echo ""
done
















