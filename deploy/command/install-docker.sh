#!/bin/bash
sudo yum -y install gcc gcc-c++
sudo yum install -y yum-utils

sudo yum-config-manager \
	--add-repo \
    http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo

sudo yum makecache fast
sudo yum install docker-ce docker-ce-cli containerd.io

systemctl start docker
systemctl enable docker