yum install gcc gcc-c++ glibc make zlib-devel pcre-devel openssl-devel -y
wget -c http://nginx.org/download/nginx-1.12.1.tar.gz
tar -xzf nginx-1.12.1.tar.gz
cd  nginx-1.12.1
./configure --prefix=/usr/local/nginx/ --with-http_stub_status_module --with-http_ssl_module --with-pcre --with-http_realip_module  --with-http_mp4_module --with-http_flv_module
make
make install
