# bash-script
🧠 build own bash script repository

关于删除的操作要谨慎!!!



## deploy

### native-deploy
源码包方式
- 部署 jar 包服务 [deploy-jar.sh]
- 部署 nginx [deploy-nginx.sh]

### command
- 下载 docker服务 [install-docker.sh]

卸载
- 卸载 docker [uninstall-docker.sh]




## database backup

### native
   备份脚本建议放到 /usr/sbin/ 目录下，以后会用管理员(root)权限调用 。
   Crontab -e 设置定时任务，注意写到末尾要将光标向左走回去一格,避免不生效,再按 esc 退出保存

```
30 4 * * * /usr/sbin/mysql_dump_db_docker.sh
```





## bash

- 删除文件大小为0的文件,一般性用于删除乱码文件,没有意义的文件 [rm_garbled_code.sh]





## docker

### 前置说明
- 使用之前注意是否需要修改端口,以及修改域名,以及修改挂载目录或者文件
- 一般性建议: 参考官方文档
[docker-example](./notes/docker.md)







## docker-compose

### 前置说明
- 命名 docker-compose.yml.service-name
- 使用之前重命名去除后面的服务名
- 使用之前注意是否需要修改端口,以及修改域名,以及修改挂载目录或者文件
- 一般性建议: 参考官方文档

### 实例
- gitlab [参考](https://docs.gitlab.com/ee/install/docker.html#install-gitlab-using-docker-compose)
默认管理账号 root,
有企业版和社区版: ee vs ce,建议直接安装企业版,决定升级到付费时候无需重新安装Gitlab
