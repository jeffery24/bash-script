docker run  -p 6379:6379 --name redis --privileged=true \
-v /app/redis/redis.conf:/etc/redis/redis.conf \
-v /app/redis/data:/data -d redis:6.0.8 redis-server /etc/redis/redis.conf
