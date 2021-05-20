<p align="center"><img src="http://nginx.org/nginx.png" width="200" /></p>

# Personal Nginx notes.

- [Nginx 是什么?](#Nginx-是什么?)
- [Nginx 特点](#Nginx-特点)
- [如何使用?](#如何使用?)
  - [MacOS](#macos)
  - [CentOS](#centos)
    - [包管理器安装](#包管理器安装)
    - [编译安装](#编译安装)
      - [安装脚本](#安装脚本)
      - [平滑升级](#平滑升级)
      - [编译参数](#编译参数)
- [配置详解](#配置文件详解)
  - [隐藏版本号](#隐藏版本号)
  - [自定义错误页](#自定义错误页)
    - [静态资源自定义错误页](#静态资源自定义错误页)
    - [反向代理自定义错误页](#反向代理自定义错误页)
- [应用场景](#应用场景)
  - [动静分离](#动静分离)
  - [正向代理](#正向代理)
  - [反向代理](#反向代理)
  - [负载均衡](#负载均衡)

## Nginx 是什么?

- 轻量级 Web 服务器
- 高性能反向代理服务器
- 电子邮件代理服务器 (IMAP/POP3/SMTP)

### Nginx 特点

1. 占用内存小
2. 并发能力强

## 如何使用?

[Nginx 下载地址](http://nginx.org/en/download.html)

### MacOS

#### 安装

```bash
$ brew install nginx
```

#### 更新

```bash
$ brew upgrade nginx
```

#### 卸载

```bash
brew uninstall nginx
```

### CentOS

#### 包管理器安装

#### 安装

```bash
# 默认安装位置 /etc/nginx
$ yum -y install nginx
```

#### 更新

```bash
$ yum update nginx
```

#### 卸载

```bash
$ yum remove nginx
```

#### 编译安装

##### 安装脚本

```bash
# 安装编译工具以及库文件
# pcre -> rewrite 功能
# openssl -> ssl 功能
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
$ nginx -v
```

##### 平滑升级

```bash
# 下载安装包
curl -O http://nginx.org/download/nginx-1.14.2.tar.gz

# 解压源码包
tar xf nginx-1.14.2.tar.gz

# 编译配置
cd nginx-1.14.2
./configure --user=nginx --prefix=/usr/local/nginx/ --with-http_stub_status_module --with-http_ssl_module --with-pcre --with-http_realip_module

# 编译安装
make

mv objs/nginx /usr/local/nginx/sbin/nginx -f

# 平滑升级
make upgrade
```

##### 编译参数

- --prefix= 指向安装目录
- --sbin-path 指向（执行）程序文件（nginx）
- --conf-path= 指向配置文件（nginx.conf）
- --error-log-path= 指向错误日志目录
- --pid-path= 指向 pid 文件（nginx.pid）
- --lock-path= 指向 lock 文件（nginx.lock）（安装文件锁定，防止安装文件被别人利用，或自己误操作。）
- --user= 指定程序运行时的非特权用户
- --group= 指定程序运行时的非特权用户组
- --builddir= 指向编译目录
- --with-rtsig_module 启用 rtsig 模块支持（实时信号）
- --with-select_module 启用 select 模块支持（一种轮询模式,不推荐在高载环境下使用）禁用：--without-select_module
- --with-poll_module 启用 poll 模块支持（功能与 select 相同，与 select 特性相同，为一种轮询模式,不推荐在高载环境下使用）
- --with-file-aio 启用 file aio 支持（一种 APL 文件传输格式）
- --with-ipv6 启用 ipv6 支持
- --with-http_ssl_module 启用 ngx_http_ssl_module 支持（使支持 https 请求，需已安装 openssl）
- --with-http_realip_module 启用 ngx_http_realip_module 支持（这个模块允许从请求标头更改客户端的 IP 地址值，默认为关）
- --with-http_addition_module 启用 ngx_http_addition_module 支持（作为一个输出过滤器，支持不完全缓冲，分部分响应请求）
- --with-http_xslt_module 启用 ngx_http_xslt_module 支持（过滤转换 XML 请求）
- --with-http_image_filter_module 启用 ngx_http_image_filter_module 支持（传输 JPEG/GIF/PNG 图片的一个过滤器）（默认为不启用。gd 库要用到）
- --with-http_geoip_module 启用 ngx_http_geoip_module 支持（该模块创建基于与 MaxMind GeoIP 二进制文件相配的客户端 IP 地址的 ngx_http_geoip_module 变量）
- --with-http_sub_module 启用 ngx_http_sub_module 支持（允许用一些其他文本替换 nginx 响应中的一些文本）
- --with-http_dav_module 启用 ngx_http_dav_module 支持（增加 PUT,DELETE,MKCOL：创建集合,COPY 和 MOVE 方法）默认情况下为关闭，需编译开启
- --with-http_flv_module 启用 ngx_http_flv_module 支持（提供寻求内存使用基于时间的偏移量文件）
- --with-http_gzip_static_module 启用 ngx_http_gzip_static_module 支持（在线实时压缩输出数据流）
- --with-http_random_index_module 启用 ngx_http_random_index_module 支持（从目录中随机挑选一个目录索引）
- --with-http_secure_link_module 启用 ngx_http_secure_link_module 支持（计算和检查要求所需的安全链接网址）
- --with-http_degradation_module 启用 ngx_http_degradation_module 支持（允许在内存不足的情况下返回 204 或 444 码）
- --with-http_stub_status_module 启用 ngx_http_stub_status_module 支持（获取 nginx 自上次启动以来的工作状态）
- --without-http_charset_module 禁用 ngx_http_charset_module 支持（重新编码 web 页面，但只能是一个方向--服务器端到客户端，并且只有一个字节的编码可以被重新编码）
- --without-http_gzip_module 禁用 ngx_http_gzip_module 支持（该模块同-with-http_gzip_static_module 功能一样）
- --without-http_ssi_module 禁用 ngx_http_ssi_module 支持（该模块提供了一个在输入端处理处理服务器包含文件（SSI）的过滤器，目前支持 SSI 命令的列表是不完整的）
- --without-http_userid_module 禁用 ngx_http_userid_module 支持（该模块用来处理用来确定客户端后续请求的 cookies）
- --without-http_access_module 禁用 ngx_http_access_module 支持（该模块提供了一个简单的基于主机的访问控制。允许/拒绝基于 ip 地址）
- --without-http_auth_basic_module 禁用 ngx_http_auth_basic_module（该模块是可以使用用户名和密码基于 http 基本认证方法来保护你的站点或其部分内容）
- --without-http_autoindex_module 禁用 disable ngx_http_autoindex_module 支持（该模块用于自动生成目录列表，只在 ngx_http_index_module 模块未找到索引文件时发出请求。）
- --without-http_geo_module 禁用 ngx_http_geo_module 支持（创建一些变量，其值依赖于客户端的 IP 地址）
- --without-http_map_module 禁用 ngx_http_map_module 支持（使用任意的键/值对设置配置变量）
- --without-http_split_clients_module 禁用 ngx_http_split_clients_module 支持（该模块用来基于某些条件划分用户。条件如：ip 地址、报头、cookies 等等）
- --without-http_referer_module 禁用 disable ngx_http_referer_module 支持（该模块用来过滤请求，拒绝报头中 Referer 值不正确的请求）
- --without-http_rewrite_module 禁用 ngx_http_rewrite_module 支持（该模块允许使用正则表达式改变 URI，并且根据变量来转向以及选择配置。如果在 server 级别设置该选项，那么他们将在 location 之前生效。如果在 location 还有更进一步的重写规则，location 部分的规则依然会被执行。如果这个 URI 重写是因为 location 部分的规则造成的，那么 location 部分会再次被执行作为新的 URI。 这个循环会执行 10 次，然后 Nginx 会返回一个 500 错误。）
- --without-http_proxy_module 禁用 ngx_http_proxy_module 支持（有关代理服务器）
- --without-http_fastcgi_module 禁用 ngx_http_fastcgi_module 支持（该模块允许 Nginx 与 FastCGI 进程交互，并通过传递参数来控制 FastCGI 进程工作。 ）FastCGI 一个常驻型的公共网关接口。
- --without-http_uwsgi_module 禁用 ngx_http_uwsgi_module 支持（该模块用来医用 uwsgi 协议，uWSGI 服务器相关）
- --without-http_scgi_module 禁用 ngx_http_scgi_module 支持（该模块用来启用 SCGI 协议支持，SCGI 协议是 CGI 协议的替代。它是一种应用程序与 HTTP 服务接口标准。它有些像 FastCGI 但他的设计 更容易实现。）
- --without-http_memcached_module 禁用 ngx_http_memcached_module 支持（该模块用来提供简单的缓存，以提高系统效率）
- -without-http_limit_zone_module 禁用 ngx_http_limit_zone_module 支持（该模块可以针对条件，进行会话的并发连接数控制）
- --without-http_limit_req_module 禁用 ngx_http_limit_req_module 支持（该模块允许你对于一个地址进行请求数量的限制用一个给定的 session 或一个特定的事件）
- --without-http_empty_gif_module 禁用 ngx_http_empty_gif_module 支持（该模块在内存中常驻了一个 1\*1 的透明 GIF 图像，可以被非常快速的调用）
- --without-http_browser_module 禁用 ngx_http_browser_module 支持（该模块用来创建依赖于请求报头的值。如果浏览器为 modern ，则$modern_browser等于modern_browser_value指令分配的值；如 果浏览器为old，则$ancient_browser 等于 ancient_browser_value 指令分配的值；如果浏览器为 MSIE 中的任意版本，则 \$msie 等于 1）
- --without-http_upstream_ip_hash_module 禁用 ngx_http_upstream_ip_hash_module 支持（该模块用于简单的负载均衡）
- --with-http_perl_module 启用 ngx_http_perl_module 支持（该模块使 nginx 可以直接使用 perl 或通过 ssi 调用 perl）
- --with-perl_modules_path= 设定 perl 模块路径
- --with-perl= 设定 perl 库文件路径
- --http-log-path= 设定 access log 路径
- --http-client-body-temp-path= 设定 http 客户端请求临时文件路径
- --http-proxy-temp-path= 设定 http 代理临时文件路径
- --http-fastcgi-temp-path= 设定 http fastcgi 临时文件路径
- --http-uwsgi-temp-path= 设定 http uwsgi 临时文件路径
- --http-scgi-temp-path= 设定 http scgi 临时文件路径
- -without-http 禁用 http server 功能
- --without-http-cache 禁用 http cache 功能
- --with-mail 启用 POP3/IMAP4/SMTP 代理模块支持
- --with-mail_ssl_module 启用 ngx_mail_ssl_module 支持
- --without-mail_pop3_module 禁用 pop3 协议（POP3 即邮局协议的第 3 个版本,它是规定个人计算机如何连接到互联网上的邮件服务器进行收发邮件的协议。是因特网电子邮件的第一个离线协议标 准,POP3 协议允许用户从服务器上把邮件存储到本地主机上,同时根据客户端的操作删除或保存在邮件服务器上的邮件。POP3 协议是 TCP/IP 协议族中的一员，主要用于 支持使用客户端远程管理在服务器上的电子邮件）
- --without-mail_imap_module 禁用 imap 协议（一种邮件获取协议。它的主要作用是邮件客户端可以通过这种协议从邮件服务器上获取邮件的信息，下载邮件等。IMAP 协议运行在 TCP/IP 协议之上， 使用的端口是 143。它与 POP3 协议的主要区别是用户可以不用把所有的邮件全部下载，可以通过客户端直接对服务器上的邮件进行操作。）
- --without-mail_smtp_module 禁用 smtp 协议（SMTP 即简单邮件传输协议,它是一组用于由源地址到目的地址传送邮件的规则，由它来控制信件的中转方式。SMTP 协议属于 TCP/IP 协议族，它帮助每台计算机在发送或中转信件时找到下一个目的地。）
- --with-google_perftools_module 启用 ngx_google_perftools_module 支持（调试用，剖析程序性能瓶颈）
- --with-cpp_test_module 启用 ngx_cpp_test_module 支持
- --add-module= 启用外部模块支持
- --with-cc= 指向 C 编译器路径
- --with-cpp= 指向 C 预处理路径
- --with-cc-opt= 设置 C 编译器参数（PCRE 库，需要指定–with-cc-opt=”-I /usr/local/include”，如果使用 select()函数则需要同时增加文件描述符数量，可以通过- –with-cc- opt=”-D FD_SETSIZE=2048”指定。）
- --with-ld-opt= 设置连接文件参数。（PCRE 库，需要指定–with-ld-opt=”-L /usr/local/lib”。）
- --with-cpu-opt= 指定编译的 CPU，可用的值为: pentium, pentiumpro, pentium3, pentium4, athlon, opteron, amd64, sparc32, sparc64, ppc64
- --without-pcre 禁用 pcre 库
- --with-pcre 启用 pcre 库
- --with-pcre= 指向 pcre 库文件目录
- --with-pcre-opt= 在编译时为 pcre 库设置附加参数
- --with-md5= 指向 md5 库文件目录（消息摘要算法第五版，用以提供消息的完整性保护）
- --with-md5-opt= 在编译时为 md5 库设置附加参数
- --with-md5-asm 使用 md5 汇编源
- --with-sha1= 指向 sha1 库目录（数字签名算法，主要用于数字签名）
- --with-sha1-opt= 在编译时为 sha1 库设置附加参数
- --with-sha1-asm 使用 sha1 汇编源
- --with-zlib= 指向 zlib 库目录
- --with-zlib-opt= 在编译时为 zlib 设置附加参数
- --with-zlib-asm= 为指定的 CPU 使用 zlib 汇编源进行优化，CPU 类型为 pentium, pentiumpro
- --with-libatomic 为原子内存的更新操作的实现提供一个架构
- --with-libatomic= 指向 libatomic_ops 安装目录
- --with-openssl= 指向 openssl 安装目录
- --with-openssl-opt 在编译时为 openssl 设置附加参数
- --with-debug 启用 debug 日志

## 常用命令

### 查看版本

```bash
$ nginx -v
```

### 查看配置

```bash
$ nginx -V
```

### 配置检查

```bash
$ nginx -t
```

### 启动服务

```bash
$ nginx -c /etc/nginx/nginx.conf
```

### 停止服务

```bash
$ nginx -s stop
$ nginx -s quit
```

### 重载配置

```bash
$ nginx -s reload
```

## 配置详解

### 隐藏版本号

#### `nginx.conf`

```diff
http {
+ server_tokens off;
}
```

#### `fastcgi_params`

```diff
- fastcgi_param  SERVER_SOFTWARE    nginx/$nginx_version;
+ fastcgi_param SERVER_SOFTWARE nginx;
```

## 自定义错误页

### 静态资源自定义错误页

```diff
server {

+   error_page  404              /404.html;
+   location = /404.html {
+       root   /www/error_pages;
+   }

+    error_page   500 502 503 504  /50x.html;
+   location = /50x.html {
+       root   /www/error_pages;
+   }
}
```

### 自定义反向代理错误页

```diff
server {
    listen       8080;
    listen  [::]:8080;
    server_name  localhost;

    location /api {
+       proxy_intercept_errors on;
        proxy_pass http://localhost:80/;
        proxy_set_header HOST   $host;
        proxy_set_header X-Real-IP      $remote_addr;
        proxy_set_header X-Forwarded-FOR $proxy_add_x_forwarded_for;
    }

+   error_page  404              /404.html;
+   location = /404.html {
+       root   /www/error_pages;
+   }

+   error_page   500 502 503 504  /50x.html;
+   location = /50x.html {
+       root   /www/error_pages;
+   }
}
```

## 应用场景

### 动静分离

### 反向代理

### 负载均衡

### 正向代理
