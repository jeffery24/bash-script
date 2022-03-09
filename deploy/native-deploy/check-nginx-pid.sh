#!/bin/bash
# 检测 nginx 是否活着,如果宕掉重新启动,如果无法启动就需要人员介入
A=`ps -C nginx --no-header |wc -l`
if [ $A -eq 0 ];then
 /usr/local/nginx/sbin/nginx
 sleep 2
 if [ `ps -C nginx --no-header |wc -l` -eq 0 ];then
 # nginx 无法启动时候,干掉所有keepalived 交给 backup keepalived提供服务
 killall keepalived
 fi
fi