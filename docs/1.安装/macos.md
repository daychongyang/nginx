## macos

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

ps -ef|grep nginx
sudo kill #$masterId

# 重新加载
sudo nginx -s reload

```
