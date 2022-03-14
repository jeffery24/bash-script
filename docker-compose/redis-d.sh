wget http://47.107.54.10/software/conf/redis-6.0.8.conf

echo "
version: "3"

services:
  redis:
    image: redis:6.0.8
    ports:
      - "6379:6379"
    volumes:
      - ./redis.conf:/etc/redis/redis.conf
      - ./data:/data
    command: redis-server /etc/redis/redis.conf
" >> ./docker-compose.yml

docker-compose up -d && docker-compose logs -f --tail 100
