简体中文 | [English](./README-en_US.md)

# Nginx CheatSheet

![nginx-1.20.0](https://img.shields.io/badge/nginx-1.20.0-blue)

- [Nginx CheatSheet](#nginx-cheatsheet)
  - [准备工作](#准备工作)
    - [实验环境](#实验环境)
    - [预置应用](#预置应用)
  - [安装](#安装)
    - [编译安装](#编译安装)
  - [语法高亮](#语法高亮)
  - [目录结构](#目录结构)
  - [常用命令](#常用命令)
  - [初始配置](#初始配置)
  - [基本语法](#基本语法)
    - [Rewrite 规则相关指令](#rewrite-规则相关指令)
      - [break 指令](#break-指令)
      - [if 指令](#if-指令)
        - [condition](#condition)
      - [return 指令](#return-指令)
      - [rewrite 指令](#rewrite-指令)
        - [flag](#flag)
      - [set 指令](#set-指令)
        - [变量Mapping](#变量mapping)

## 准备工作

### 实验环境

```bash
$ chmod a+x playground.sh

$ ./playground.sh
```

### 预置应用

```
$ yum install vim tree make -y
```

## 安装

### 编译安装

```bash
$ yum install gcc zlib zlib-devel pcre pcre-devel openssl openssl-devel -y
$ cd /usr/local/src
$ curl -O http://nginx.org/download/nginx-1.20.0.tar.gz
$ tar -xzf nginx-1.20.0.tar.gz
$ cd nginx-1.20.0
$ ./configure --prefix=/usr/local/nginx
$ make && make install
$ ln -s /usr/local/nginx/sbin/nginx /usr/bin/nginx
$ nginx -V
```

## 语法高亮

```
$ cp -r /usr/local/src/nginx-1.20.0/contrib/vim/* ~/.vim
```

## 目录结构

```bash
tree .
.
|-- conf
|   |-- fastcgi.conf
|   |-- fastcgi.conf.default
|   |-- fastcgi_params
|   |-- fastcgi_params.default
|   |-- koi-utf
|   |-- koi-win
|   |-- mime.types
|   |-- mime.types.default
|   |-- nginx.conf
|   |-- nginx.conf.default
|   |-- scgi_params
|   |-- scgi_params.default
|   |-- uwsgi_params
|   |-- uwsgi_params.default
|   `-- win-utf
|-- html
|   |-- 50x.html
|   `-- index.html
|-- logs
`-- sbin
    `-- nginx

4 directories, 18 files
```

## 常用命令

```bash
$ nginx -h
nginx version: nginx/1.20.0
Usage: nginx [-?hvVtTq] [-s signal] [-p prefix]
             [-e filename] [-c filename] [-g directives]

Options:
  -?,-h         : this help
  -v            : show version and exit
  -V            : show version and configure options then exit
  -t            : test configuration and exit
  -T            : test configuration, dump it and exit
  -q            : suppress non-error messages during configuration testing
  -s signal     : send signal to a master process: stop, quit, reopen, reload
  -p prefix     : set prefix path (default: /usr/local/nginx/)
  -e filename   : set error log file (default: logs/error.log)
  -c filename   : set configuration file (default: conf/nginx.conf)
  -g directives : set global directives out of configuration file
```

```bash
$ nginx               启动服务
$ nginx -h            查看帮助
$ nginx -v            查看版本
$ nginx -V            查看版本和编译参数
$ nginx -t            检查配置文件语法
$ nginx -T            检查配置文件语法, 并显示配置文件
$ nginx -q            检查配置文件语法, 只显示错误信息
$ nginx -c filename   指定配置文件
$ nginx -s stop       立即停止服务
$ nginx -s quit       平滑停止服务
$ nginx -s reload     平滑重启服务
```

## 初始配置

```bash
$ cat /usr/local/nginx/conf/nginx.conf

#user  nobody;
worker_processes  1;

#error_log  logs/error.log;
#error_log  logs/error.log  notice;
#error_log  logs/error.log  info;

#pid        logs/nginx.pid;


events {
    worker_connections  1024;
}


http {
    include       mime.types;
    default_type  application/octet-stream;

    #log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
    #                  '$status $body_bytes_sent "$http_referer" '
    #                  '"$http_user_agent" "$http_x_forwarded_for"';

    #access_log  logs/access.log  main;

    sendfile        on;
    #tcp_nopush     on;

    #keepalive_timeout  0;
    keepalive_timeout  65;

    #gzip  on;

    server {
        listen       80;
        server_name  localhost;

        #charset koi8-r;

        #access_log  logs/host.access.log  main;

        location / {
            root   html;
            index  index.html index.htm;
        }

        #error_page  404              /404.html;

        # redirect server error pages to the static page /50x.html
        #
        error_page   500 502 503 504  /50x.html;
        location = /50x.html {
            root   html;
        }

        # proxy the PHP scripts to Apache listening on 127.0.0.1:80
        #
        #location ~ \.php$ {
        #    proxy_pass   http://127.0.0.1;
        #}

        # pass the PHP scripts to FastCGI server listening on 127.0.0.1:9000
        #
        #location ~ \.php$ {
        #    root           html;
        #    fastcgi_pass   127.0.0.1:9000;
        #    fastcgi_index  index.php;
        #    fastcgi_param  SCRIPT_FILENAME  /scripts$fastcgi_script_name;
        #    include        fastcgi_params;
        #}

        # deny access to .htaccess files, if Apache's document root
        # concurs with nginx's one
        #
        #location ~ /\.ht {
        #    deny  all;
        #}
    }


    # another virtual host using mix of IP-, name-, and port-based configuration
    #
    #server {
    #    listen       8000;
    #    listen       somename:8080;
    #    server_name  somename  alias  another.alias;

    #    location / {
    #        root   html;
    #        index  index.html index.htm;
    #    }
    #}


    # HTTPS server
    #
    #server {
    #    listen       443 ssl;
    #    server_name  localhost;

    #    ssl_certificate      cert.pem;
    #    ssl_certificate_key  cert.key;

    #    ssl_session_cache    shared:SSL:1m;
    #    ssl_session_timeout  5m;

    #    ssl_ciphers  HIGH:!aNULL:!MD5;
    #    ssl_prefer_server_ciphers  on;

    #    location / {
    #        root   html;
    #        index  index.html index.htm;
    #    }
    #}
}

```

## 基本语法

1.  配置文件由指令和指令块构成

    ```bash # 指令
    worker_processed 1;

        # 指令块
        http {
            # ...
        }
    ```

2.  指令以分号(`;`)结尾
3.  允许使用 `include` 语句组合多个配置文件以提升可维护性
4.  允许使用 `#` 符号添加注释
5.  允许使用 `$` 符号使用变量
    | 变量 | 描述 |
    | ----------- | ----------- |
    | `$args` | GET 请求中的参数值 |
    | `$arg_NAME` | GET 请求中变量名 `NAME` 参数的值 |
    | `$is_args` | 若请求中有参数, 值为`?`, 否则为空字符串 |
    | `$uri` | 请求 `URI` |
    | `$document_uri` | 同 `$uri` |
    | `$document_root` | 当前请求的文档根目录或别名 |
    | `$host` | HTTP 请求行的主机名 > "HOST"请求头字段 > 符合请求的服务器名 |
    | `$hostname` | 主机名 |
    | `$https` | 若开启了 SSL 安全模式, 值为 `on`, 否则为空字符串 |
    | `$binary_remote_addr` | 客户端地址的二进制形式 |
    | `$bytes_sent` | 传输给客户端的字节数 |
    | `$body_bytes_sent` | 传输给客户端的字节数，响应头不计算在内 |
    | `$connection` | TCP 连接的序列号 |
    | `$connection_requests` | TCP 连接当前的请求数量 |
    | `$content_length` | `Content-Length` 请求头字段 |
    | `$content_type` | `Content-Type` 请求头字段 |
    | `$cookie_NAME` | cookie 名称 |
    | `$http_NAME` | 请求头字段 |
    | `$limit_rate` | 用于设置响应的速度限制 |
    | `$msec` | 当前的 Unix 时间戳 |
    | `$nginx_version` | nginx 版本 |
    | `$pid` | 工作进程的 PID |
    | `$remote_addr` | 客户端地址 |
    | `$remote_port` | 客户端端口 |
    | `$remote_user` | 用于 HTTP 基础认证服务的用户名 |
    | `$request` | 客户端的请求地址 |
    | `$request_body` | 客户端的请求主体 |
    | `$request_filename` | 前连接请求的文件路径 |
    | `$request_length` | 请求的长度 |
    | `$request_method` | HTTP 请求方法 |
    | `$request_time` | 处理客户端请求使用的时间,单位为秒 |
    | `$request_uri` | 处理客户端请求使用的时间,单位为秒 |
    | `$scheme` | 请求协议 |
    | `$sent_http_NAME` | http 响应头字段 |
    | `$server_addr` | 服务器端地址 |
    | `$server_name` | 服务器名 |
    | `$server_port` | 服务器端口 |
    | `$server_protocol` | 服务器的 HTTP 版本 |
    | `$status` | HTTP 响应代码 |

### Rewrite 规则相关指令

#### break 指令

上下文: `server` `location` `if`

停止处理当前这一轮的 `ngx_http_rewrite_module` 指令集。

```bash
if ($slow) {
    limit_rate 10k;
    break;
}
```

#### if 指令
语法:	`if (condition) { ... }`

上下文: `server` `location`

计算指定的condition的值。如果为真，执行定义在大括号中的rewrite模块指令，并将if指令中的配置指定给请求。

`if` 指令不支持嵌套, 不支持多个条件 `&&`、`||`处理

##### condition 
- 变量名 `$invalid_referer`
- 使用 `=` `!=` 运算符比较变量和字符串
- 使用 `~` (大小写敏感) `~*` (大小写不敏感) 运算符正则匹配
- 使用 `!~` (大小写敏感) `!~*` (大小写不敏感) 运算符正则不匹配
- 使用 `-f` `!-f` 运算符检查文件是否存在
- 使用 `-d` `!-d` 运算符检查目录是否存在
- 使用 `-e` `!-e` 运算符检查目录、文件、符号链接是否存在
- 使用 `-x` `!-x` 运算符检查文件是否可执行

```bash
if ($http_user_agent ~ MSIE) {
    rewrite ^(.*)$ /msie/$1 break;
}

if ($http_cookie ~* "id=([^;]+)(?:;|$)") {
     set $id $1;
}

if ($http_request_method = POST) {
    return 405;
}

if ($invalid_referer) {
    return 403;
}
```

#### return 指令

语法: `return code [text]` | `return code URL` | `return URL;`

上下文: `server` `location` `if`

停止处理并返回指定code给客户端。

```bash
server {
	listen 8080;
	server_name localhost;
	
	location = /hello {
		default_type text/html;
		return 200 'hello, nginx!';
	}
}
```

#### rewrite 指令

语法: `	rewrite regex replacement [flag];`

上下文: `server` `location` `if`

该指令根据表达式来重定向`URI`, 或者修改字符串.

```bash
server {
    listen 8080;
    server_name localhost;

    # 重定向 
    location /redirect {
        rewrite /redirect/(.*) https://www.$1.com;
        return 200 "ok";
    }

    # 永久重定向
    location /permanent-rewrite {
        rewrite (.*) /result permanent;
        return 200 "ok";
    }

    # 临时重定向  
    location /redirect {
        rewrite (.*) /result redirect;
        return 200 "ok";
    }

    # 重写字符串 
    location /rewrite-string {
        rewrite (.*) /result;
        return 200 "ok";
    }
}
```
##### flag
- last 停止执行当前这一轮的 ngx_http_rewrite_module指令集，然后查找匹配改变后URI的新location；
- break 停止执行当前这一轮的ngx_http_rewrite_module指令集；
- redirect 在replacement字符串未以“http://”或“https://”开头时，使用返回状态码为302的临时重定向；
- permanent 返回状态码为301的永久重定向

#### set 指令

上下文: `server` `location` `if`

该指令用于定义一个变量, 并给变量赋值

```bash
set $foo hello;
```


##### 变量Mapping
```bash
map $args $foo {
    default 0;
    debug 1;
}

server {
    listen 8080;
    location /test {

        set $orig_foo $foo;       #先把当前$foo变量的值保存在另一个用户变量$orig_foo中
        set $args debug;         #然后强行把$args的值改为debug
        echo "original foo is:$orig_foo";
        echo "foo is:$foo";
    }
}
```