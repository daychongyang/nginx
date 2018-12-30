# events

事件模块可以使用指令来配置网络机制，某些参数可能会直接应用程序性能

- use epoll; # 可用的事件的模型,默认会选择一个最适合当前操作系统;
  - select：只能在 Windows 下使用，这个事件模型不建议在高负载的系统使用;
  - poll:Nginx 默认首选，但不是在所有系统下都可用;
  - kqueue:这种方式在 FreeBSD 4.1+, OpenBSD2.9+, NetBSD 2.0, 和 MacOS X 系统中是最高效的;
  - epoll: 这种方式是在 Linux 2.6+内核中最高效的方式;
  - rtsig:实时信号，可用在 Linux 2.2.19 的内核中，但不适用在高流量的系统中;
  - /dev/poll: Solaris 7 11/99+,HP/UX 11.22+, IRIX 6.5.15+, and Tru64 UNIX 5.1A+操作系统最高效的方式;
  - eventport: Solaris 10 最高效的方式
- accept_mutex on; # 开启或者禁用使用互斥锁来打开 sockets, 默认为 on;
- accept_mutex_delay 500ms; # 定义 worker 进程等待多长时间再次获取资源, 默认为 500ms;
- multi_accept on; # 设置是否允许同时接受多个网络连接, 默认为 off;
- worker_connections 65535; # 工作进程的最大连接数量, 理论上每台 nginx 服务器的最大连接数为 worker_processes\*worker_connections;
- keepalive_timeout 60; # http keepalive 超时时间;
- client_header_buffer_size 4k; # 客户端请求头部的缓冲区大小;
- open_log_file_cache max=1000 inactive=20s valid=1m min_uses=2;
  - max - 缓存中存储的最大文件描述符数。
  - inactive - 设置缓存中在某个时间段内没有使用的文件描述符将被移除，默认为 10 秒。
  - min_uses - 在一定时间内（inactive 指定），一个文件描述符最少使用多少次后被放入缓存，默认为 1。
  - valid - 设置检查同名文件存在的时间，默认是 60 秒。
  - off - 关闭缓存。
