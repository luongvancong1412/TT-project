# Cấu hình port

Bài này thực hiện đổi port cho từng Virtual host cho bài lab: [Cấu hình Virutual host](./Cau-hinh-virtual-host.md)

Mục lục
- [Cấu hình port](#cấu-hình-port)
  - [1. Kiến thức cơ bản](#1-kiến-thức-cơ-bản)
  - [2. Cấu hình port](#2-cấu-hình-port)

## 1. Kiến thức cơ bản
- Ta có thể cấu hình port trong Server Block
- Block Directive để cấu hình port cho virtual host là:

```
listen <port>;
```
## 2. Cấu hình port
> Sử dụng port 8080 trên congvhost1.world

Xem tệp cấu hình của congvhost1.world:
```
cat /etc/nginx/conf.d/congvhost1.world.conf
```
Output:
```
#/etc/nginx/conf.d/congvhost1.world.conf
server {
    listen 80;
    server_name     congvhost1.world www.congvhost1.world;

    access_log      /var/log/nginx/access-congvhost1.world.log;
    error_log       /var/log/nginx/error-congvhost1.world.log;

    root    /usr/share/nginx/congvhost1.world;
    index   index.html;
}
```
Thay đổi port:
```
sed -i 's/listen 80;/listen 8080;/g' /etc/nginx/conf.d/congvhost1.world.conf
```

> Sử dụng port 8081 trên congvhost2.world

Xem tệp cấu hình của congvhost2.world:
```
cat /etc/nginx/conf.d/congvhost2.world.conf
```
Output:
```
#/etc/nginx/conf.d/congvhost1.world.conf
server {
    listen 80;
    server_name     congvhost.world www.congvhost1.world;

    access_log      /var/log/nginx/access-congvhost1.world.log;
    error_log       /var/log/nginx/error-congvhost1.world.log;

    root    /usr/share/nginx/congvhost2.world;
    index   index.html;
}
```
Thay đổi port:
```
sed -i 's/listen 80;/listen 8081;/g' /etc/nginx/conf.d/congvhost2.world.conf
```

Kiểm tra:
```
nginx -t
```
Khởi động lại file cấu hình:
```
nginx -s reload
```
Cấu hình firewall:
```
firewall-cmd --zone=public --permanent --add-port=8080/tcp
firewall-cmd --zone=public --permanent --add-port=8081/tcp
firewall-cmd --reload
```

