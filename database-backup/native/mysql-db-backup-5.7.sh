#!/bin/bash
# 备份目录
BACKUP=/data/mysql/db
#当前时间
DATETIME=$(date +%Y-%m-%d_%H%M%S)
echo "DATETIME=$DATETIME"
#定义数据库相关
#数据库的用户名
DB_USER=root
#数据库的密码
DB_PW=yourpassword
#备份的数据库名
DATABASE=databaseName
#数据库的地址
HOST=localhost

# 备份的目录 如果不存在则创建
[ !-d"${BACKUP}/${DATETIME}" ] && mkdir -p "${BACKUP}/${DATETIME}"

# 备份数据库
mysqldump -u${DB_USER} -p${DB_PW} --host=${HOST} -q -R --databases ${DATABASE} | gzip > ${BACKUP}/${DATETIME}/$DATETIME.sql.gz

# 将文件处理成tar.gz
cd ${BACKUP}
tar -zcvf $DATETIME.tar.zip ${DATETIME}
#删除对于的备份目录
rm -rf ${BACKUP}/${DATETIME}

#删除10 天前的备份文件
find ${BACKUP} -atime +10 -name "*.tar.zip" -exec rm -rf {} \;
echo "备份数据库${DATABASE}成功"