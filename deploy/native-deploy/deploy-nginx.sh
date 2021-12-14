echo "starting install native nginx web server"
# 安装编译工具和库
yum -y install make zlib zlib-devel gcc-c++ libtool \
openssl openssl-devel prce prce-devel

wget https://nginx.org/download/nginx-1.20.2.tar.gz
mkdir /var/temp/nginx -p
mkdir /usr/nginx && cd /usr/nginx
tar -zxvf nginx-1.20.2.tar.gz
cd nginx-1.20.2

./configure \
--prefix=/usr/local/nginx \
--pid-path=/var/run/nginx/nginx.pid \
--lock-path=/var/lock/nginx.lock \
--with-http_gzip_static_module \
--http-client-body-temp-path=/var/temp/nginx/client \
--http-proxy-temp-path=/var/temp/nginx/proxy \
--http-fastcgi-temp-path=/var/temp/nginx/fastcgi \
--http-uwsgi-temp-path=/var/temp/nginx/uwsgi \
--http-scgi-temp-path=/var/temp/nginx/scgi \
--with-http_ssl_module

make && make install

cd /usr/local/nginx
./sbin/nginx
echo "nginx web server is successfully! installed and working"
