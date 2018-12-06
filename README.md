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

### macos

#### 安装 `homebrew`

`/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"`

#### 安装 `nginx`

```sh
# 安装
brew install nginx

# 默认安装路径 /usr/local/Cellar/nginx/
```

#### 查看 `nginx` 安装位置

```sh
# 查看版本
nginx -v

# 查看版本 编译配置 安装路径
nginx -V
```

#### 启动、停止、重载方式

```sh
# 启动
sudo nginx

# 停止
sudo nginx -s stop # 无日志

sudo nginx -s quit # 有日志

# 重新加载
sudo nginx -s reload
```

### windows

[nginx download](http://nginx.org/en/download.html)

#### 启动、停止、重载方式

```sh
# 启动
C:\server\nginx-1.12.2>start nginx #(可后台)

C:\server\nginx-1.12.2>nginx.exe #(不可后台)

# 停止
C:\server\nginx-1.12.2>nginx.exe -s stop #(快速停止)

C:\server\nginx-1.12.2>nginx.exe -s quit #(从容停止)

# 重新加载配置
C:\server\nginx-1.12.2>nginx.exe -s reload

# 查看版本
C:\server\nginx-1.12.2>nginx -v
```

#### 快速启动脚本

`nginx-stop.bat`

```
c:
cd \server\nginx-1.12.2
nginx.exe
exit
```

`nginx-stop.bat`

```
c:
cd \server\nginx-1.12.2
nginx.exe -s stop
exit
```

`nginx-reload.bat`

```
c:
cd \server\nginx-1.12.2
nginx.exe -s -reload
exit
```
