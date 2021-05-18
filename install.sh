#!/bin/bash

# 安装依赖关系包
yum install zlib zlib-devel openssl openssl-devel pcre pcre-devel gcc gcc-c++ autoconf automake make -y

# 下载安装包
curl -O http://nginx.org/download/nginx-1.12.2.tar.gz

# 新建用户
useradd nginx -s /sbin/nologin

# 解压源码包
tar xf nginx-1.12.2.tar.gz

# 编译配置 
cd nginx-1.12.2
./configure --user=nginx --prefix=/usr/local/nginx/ --with-http_stub_status_module --with-http_ssl_module --with-pcre --with-http_realip_module

# 编译安装
make
make install

# 设置软链
ln -s /usr/local/nginx/sbin/nginx /usr/bin/nginx

# 查看 Nginx 版本
nginx -v