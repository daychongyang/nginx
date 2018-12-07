## linux:centos

### 编译安装(服务性能更好)

```sh
yum install gcc gcc-c++ glibc make zlib-devel pcre-devel openssl-devel -y
wget -c http://nginx.org/download/nginx-1.12.1.tar.gz
tar -xzf nginx-1.12.1.tar.gz
cd  nginx-1.12.1
./configure --prefix=/usr/local/nginx/ --with-http_stub_status_module --with-http_ssl_module --with-pcre --with-http_realip_module
make
make install
```

#### 查看 nginx 安装位置

```sh
rpm -ql nginx
```

#### 卸载 nginx

```sh

# 无依赖包
rpm -e nginx

# 有依赖包
rpm -e --nodeps nginx
```

#### 启动、停止、重载方式

```sh
# 启动
/usr/local/nginx/sbin/nginx

# 停止
/usr/local/nginx/sbin/nginx -s stop

# or
ps -ef|grep nginx

kill -Hum $masterId # 不重新加载配置的情况下启动进行

kill -QUIT $masterId # 从容停止

kill -TERM $masterId # 快速停止

kill -9 $masterId # 强制停止

kill -(HUP|TERM|QUIT) cat /usr/local/nginx/nginx.pid

# 重启
/usr/local/nginx/sbin/nginx -s reload

```

---

### 包管理器安装(不容易出错)

```sh
yum -y install nginx
```

#### 安装位置

默认为 `/usr/local/nginx`

#### 卸载 nginx

直接卸载`/usr/local/nginx`文件夹

#### 启动方式

```sh
# 启动
service nginx start

# 停止
service nginx stop

# 重启
service nginx restart
```
