#!/bin/bash
echo "=================start install================="

wget https://keepalived.org/software/keepalived-2.2.4.tar.gz --no-check-certificate
tar -zxvf keepalived-2.2.4.tar.gz

# fix warning build will not support IPVS with IPv6
yum -y install libnl libnl-devel

# 将 keepalived 安装到指定目录
./configure --prefix=/usr/local/keepalived --sysconf=/etc

make && make install

echo "=================end install================="
