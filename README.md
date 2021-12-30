# bash-script
🧠 build own bash script repository



## deploy

### native-deploy
源码包方式
- 部署 jar 包服务 [deploy-jar.sh]
- 部署 nginx [deploy-nginx.sh]





## database backup

### native
   备份脚本建议放到 /usr/sbin/ 目录下，以后会用管理员(root)权限调用 。
   Crontab -e 设置定时任务，注意写到末尾要将光标向左走回去一格,避免不生效,再按 esc 退出保存

```
30 4 * * * /usr/sbin/mysql_dump_db_docker.sh
```

