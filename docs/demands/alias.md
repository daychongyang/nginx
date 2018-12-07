## alias 指令

`$path/sites/static-server.conf`

```sh
server {
    listen 82;
    add_header 'Access-Control-Allow-Origin' '*';
    add_header "X-UA-Compatible" "IE=Edge, chrome=1";
    server_name localhost;
    root /Users/dcy/awesome/nginx-ge-profile/websites/a;
    location /images/a/ {
        alias /Users/dcy/awesome/nginx-ge-profile/websites/public/images/;
    }
}

```

`alias location 匹配,尾缀要写都写,要不写都不写.`
