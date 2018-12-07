## 静态文件服务

`$path/sites/static-server.conf`

```sh
server {
    listen 10001;
    add_header 'Access-Control-Allow-Origin' '*';
    add_header "X-UA-Compatible" "IE=Edge, chrome=1";
    server_name localhost;
    root /Users/dcy/awesome/nginx-ge-profile/websites/a;
}
```
