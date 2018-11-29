# 🌱 nginx-conf

## 项目介绍

nginx 通用配置

## 为什么需要使用 Nginx?

- Web 服务器: 使用更少的资源,支持更多的并发连接.
- 负载均衡服务器: 系统资源开销,CPU 使用效率更好.
- 邮件代理服务器

## 安装

### linux:centos

#### 编译安装(服务性能更好)

```sh
yum install gcc gcc-c++ glibc make zlib-devel pcre-devel openssl-devel -y
wget -c http://nginx.org/download/nginx-1.12.1.tar.gz
tar -xzf nginx-1.12.1.tar.gz
cd  nginx-1.12.1
./configure --prefix=/usr/local/nginx/ --with-http_stub_status_module --with-http_ssl_module --with-pcre --with-http_realip_module  --with-http_mp4_module --with-http_flv_module
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

#### 启动方式

```sh
# 启动
/usr/local/nginx/sbin/nginx

# 停止
/usr/local/nginx/sbin/nginx -s stop

# 重启
/usr/local/nginx/sbin/nginx -s reload
```

---

#### 包管理器安装(不容易出错)

```sh
yum -y install nginx
```

#### 安装位置

默认为 `/usr/local/nginx`

#### 卸载  nginx

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

### macos
