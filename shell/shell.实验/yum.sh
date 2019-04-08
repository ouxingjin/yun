#!/bin/bash
#配置yum源
adyum() {
        yum="[rhel]
        name=rhel7.4
        baseurl=ftp://192.168.2.254/rhel7
        enabled=1
        gpgcheck=0"
for i in $yum
do
      echo $i >> /etc/yum.repos.d/rhel.repo
done
}
adyum
