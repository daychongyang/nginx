# Personal Nginx notes.

![nginx-1.20.0](https://img.shields.io/badge/nginx-1.20.0-blue)

- [Preparation](#preparation)
  - [Playground](#playground)
  - [Preflight](#preflight)
- [Installation](#installation)
- [Syntax highlighting](#syntax-highlighting)

## Preparation

## Playground

```bash
$ chmod a+x playground.sh

$ ./playground.sh
```

## Preflight

```
$ yum install vim tree gcc zlib-devel pcre-devel make -y
```

## Installation

```bash
$ cd /usr/local/src
$ curl -O http://nginx.org/download/nginx-1.20.0.tar.gz
$ tar -xzf nginx-1.20.0.tar.gz
$ ./configure --prefix=/usr/local/nginx
$ make
$ make install
$ ln -s /usr/local/nginx/sbin/nginx /usr/bin/nginx
$ nginx -V
```

## Syntax highlighting

```
$ cp -r /usr/local/src/nginx-1.20.0/contrib/vim/* ~/.vim
```
