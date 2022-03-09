#!/bin/bash
# j: 删除指定目录下所有乱码文件,乱码文件一般大小都为0

# 获取文件夹下所有文件
folder="/root/java-service"

soft_files=$(ls $folder)

for sfile in ${soft_files}
do
	if [ ! -s "${sfile}" ]
	then
	       echo "soft: ${sfile}"
	       rm ${sfile}
	fi
done
