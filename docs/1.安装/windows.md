## windows

[nginx download](http://nginx.org/en/download.html)

#### 启动、停止、重载方式

```sh
# 启动
C:\server\nginx-1.12.2\start nginx #(可后台)

C:\server\nginx-1.12.2\nginx.exe #(不可后台)

# 停止
C:\server\nginx-1.12.2\nginx.exe -s stop #(快速停止)

C:\server\nginx-1.12.2\nginx.exe -s quit #(从容停止)

# 重新加载配置
C:\server\nginx-1.12.2\nginx.exe -s reload

# 查看版本
C:\server\nginx-1.12.2\nginx -v
```

#### bat 脚本

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
