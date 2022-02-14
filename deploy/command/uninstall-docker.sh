#!/bin/bash
systemctl stop docker

sudo yum remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-engine

# 删除docker相关数据
rm -rf /var/lib/docker
rm -rf /var/lib/containerd