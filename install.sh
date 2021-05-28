#!/bin/bash
yum install make gcc zlib zlib-devel pcre pcre-devel openssl openssl-devel -y
cd /usr/local/src
curl -O http://nginx.org/download/nginx-1.20.0.tar.gz
tar -xzf nginx-1.20.0.tar.gz
cd nginx-1.20.0
./configure --prefix=/usr/local/nginx
make && make install
ln -s /usr/local/nginx/sbin/nginx /usr/bin/nginx
