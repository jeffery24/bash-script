# redis 6.0.8 默认出厂配置文件
# 无需修改daemonize 为yes 可能导致无法启动
wget http://47.107.54.10/software/conf/redis-6.0.8.conf

docker run  -p 6379:6379 --name redis --privileged=true \
-v /app/redis/redis.conf:/etc/redis/redis.conf \
-v /app/redis/data:/data -d redis:6.0.8 redis-server /etc/redis/redis.conf
