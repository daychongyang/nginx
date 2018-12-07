# 运行、控制 Nginx

## Nginx 命令行参数

- -c 为 nginx 指定 配置文件,来代替缺省.

- -t 测试配置文件,检查配置文件语法的正确性.

- -v 查看 nginx 版本.

- -V 查看 nginx 、编译器版本和配置参数.

## Nginx 控制信号

| 信号      | 作用             |
| --------- | ---------------- |
| TERM、INT | 快速关闭         |
| QUIT      | 从容关闭         |
| USR1      | 重新打开日志文件 |

```sh
# 查看 pid
ps -ef|grep nginx

# 从容停止服务,等待所有请求结束之后在关闭服务
kill -QUIT $pid

# 快熟停止,立刻关闭进程
kill -TERM $pid

# 强制停止
kill -9 $pid

# 不查看命令号直接强制停止
kill -(HUP|TREM|QUIT) `cat /usr/local/nginx/nginx.pid`
```
