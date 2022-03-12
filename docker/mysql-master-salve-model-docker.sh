# 主库
docker run -p 3307:3306 --name mysql-master \
-v /mydata/mysql-master/log:/var/log/mysql \
-v /mydata/mysql-master/data:/var/lib/mysql \
-v /mydata/mysql-master/conf:/etc/mysql \
-e MYSQL_ROOT_PASSWORD=root  \
-d mysql:5.7

# 新建 my.cnf 数据库配置文件
touch /mydata/mysql-master/conf/my.cnf
echo  "
[mysqld]
## 设置server_id，同一局域网中需要唯一
server_id=101
## 指定不需要同步的数据库名称
binlog-ignore-db=mysql
## 开启二进制日志功能
log-bin=mall-mysql-bin
## 设置二进制日志使用内存大小（事务）
binlog_cache_size=1M
## 设置使用的二进制日志格式（mixed,statement,row）
binlog_format=mixed
## 二进制日志过期清理时间。默认值为0，表示不自动清理。
expire_logs_days=7
## 跳过主从复制中遇到的所有错误或指定类型的错误，避免slave端复制中断。
## 如：1062错误是指一些主键重复，1032错误是因为主从数据库数据不一致
slave_skip_errors=1062
" >> /mydata/mysql-master/conf/my.cnf

docker restart mysql-master

#进入容器创建数据同步用户
docker exec -it mysql-master /bin/bash
mysql -uroot -p
CREATE USER 'slave'@'%' IDENTIFIED BY '123456' ;
GRANT REPLICATION SLAVE, REPLICATION CLIENT ON *.* TO 'slave'@'%';

# 从库
docker run -p 3308:3306 --name mysql-slave \
-v /mydata/mysql-slave/log:/var/log/mysql \
-v /mydata/mysql-slave/data:/var/lib/mysql \
-v /mydata/mysql-slave/conf:/etc/mysql \
-e MYSQL_ROOT_PASSWORD=root  \
-d mysql:5.7

touch /mydata/mysql-slave/conf/my.cnf
echo "
[mysqld]
## 设置server_id，同一局域网中需要唯一
server_id=102
## 指定不需要同步的数据库名称
binlog-ignore-db=mysql
## 开启二进制日志功能，以备Slave作为其它数据库实例的Master时使用
log-bin=mall-mysql-slave1-bin
## 设置二进制日志使用内存大小（事务）
binlog_cache_size=1M
## 设置使用的二进制日志格式（mixed,statement,row）
binlog_format=mixed
## 二进制日志过期清理时间。默认值为0，表示不自动清理。
expire_logs_days=7
## 跳过主从复制中遇到的所有错误或指定类型的错误，避免slave端复制中断。
## 如：1062错误是指一些主键重复，1032错误是因为主从数据库数据不一致
slave_skip_errors=1062
## relay_log配置中继日志
relay_log=mall-mysql-relay-bin
## log_slave_updates表示slave将复制事件写进自己的二进制日志
log_slave_updates=1
## slave设置为只读（具有super权限的用户除外）
read_only=1
" >> /mydata/mysql-slave/conf/my.cnf

host_ip = `ifconfig eth0 |awk -F '[ :]+' 'NR==2 {print $3}'`
echo `ifconfig eth0 |awk -F '[ :]+' 'NR==2 {print $3}'`
# 修改配置后重启 slave 实例
docker restart mysql-slave
# 进入容器配置主从
docker exec -it  mysql-master  mysql -uroot -proot
# 主库查看同步状态
show master status;

change master to master_host='172.27.140.32', master_user='slave', \
master_password='123456', master_port=3307,\
master_log_file='mall-mysql-bin.000001', \
master_log_pos=154, master_connect_retry=30;
  # master_host：主数据库的IP地址；
  # master_port：主数据库的运行端口；
  # master_user：在主数据库创建的用于同步数据的用户账号；
  # master_password：在主数据库创建的用于同步数据的用户密码；
  # master_log_file：指定从数据库要复制数据的日志文件，通过查看主数据的状态，获取File参数；
  # master_log_pos：指定从数据库从哪个位置开始复制数据，通过查看主数据的状态，获取Position参数；
  # master_connect_retry：连接失败重试的时间间隔，单位为秒。


 show slave status \G;
 start slave;
 show slave status \G;
         # Slave_IO_Running: Yes
         # Slave_SQL_Running: Yes
#如果此时出现 Slave_IO_Running: No 情况，重启一下主机,重新配置主从,stop slave; 重新change 

 # 测试
 # 主机
 create database db1;
 use db1;
 create table t1(id int,name varchar(20));
 insert into t1 values(1,"yo");

 # 从机
 use db1;
 select * from t1;
