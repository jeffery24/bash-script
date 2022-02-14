#!/bin/bash
jar_file=jeff.jar
service_name=jeff
datetime=$(date +%Y-%m-%d)
log_file=./${service_name}-${datetime}.log

echo "=================publish================="

process_id=`ps -ef | grep ${jar_file} | grep -v grep |awk '{print $2}'`
if [ $process_id ] ; then
sudo kill -9 $process_id
fi

source /etc/profile
nohup java -jar -Dspring.profiles.active=prod ./${jar_file} > ${log_file} 2>&1 &

echo "=================end publish================="
