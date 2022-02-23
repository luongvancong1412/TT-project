# Tách file cấu hình lab: Nginx-proxy

Bài viết này thực hiện tách file cấu hình của bài lab: [nginx-proxy](./nginx-proxy-nangcao.md/#ii-lab). Từ `/etc/nginx/conf.d/test.conf` thành 2 file:
- `/etc/nginx/conf.d/test.conf` sử dụng cho Apache server 1 (Node 1)
- `/etc/nginx/conf.d/test1.conf` sử dụng cho Apache server 2 (Node 2)


Mục lục
- [Tách file cấu hình lab: Nginx-proxy](#tách-file-cấu-hình-lab-nginx-proxy)
  - [1. Mô hình mạng](#1-mô-hình-mạng)
  - [2. Tách file cấu hình](#2-tách-file-cấu-hình)
  - [3. Kiểm tra:](#3-kiểm-tra)
- [Tài liệu tham khảo](#tài-liệu-tham-khảo)

## 1. Mô hình mạng

![](../image/proxy-nangcap.png)

Mô hình IP:

![](../image/ipproxynangcao.png)

## 2. Tách file cấu hình
Thực hiện tách file `/etc/nginx/conf.d/test.conf` thành 2 file cho từng Apache Server

> Thực hiện trên node3 (Nginx Proxy)

Sửa tệp cấu hình:
```
vi /etc/nginx/nginx.conf
```
Bỏ dòng 31:
```
31     #include /etc/nginx/conf.d/*.conf;
```
Thêm dòng sau vào cuối **HTTP Block**:
```
    server {
        #server_name example.com;
        listen      [::]:80 default_server;
        listen      80 default_server;

        include /etc/nginx/conf.d/*.conf;
}
```
Sửa file `/etc/nginx/conf.d/test.conf` sử dụng cho node1
```
echo '#/etc/nginx/conf.d/test.conf
location / {
    proxy_redirect           off;
    proxy_set_header         X-Real-IP $remote_addr;
    proxy_set_header         X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header         Host $http_host;
    proxy_pass http://192.168.77.70/;
}' > /etc/nginx/conf.d/test.conf
```

Cấu hình file `/etc/nginx/conf.d/test1.conf` sử dụng cho node2
```
echo '#/etc/nginx/conf.d/test1.conf
location /cong/ {
    proxy_redirect           off;
    proxy_set_header         X-Real-IP $remote_addr;
    proxy_set_header         X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header         Host $http_host;
    proxy_pass http://192.168.77.71/cong/;
}' > /etc/nginx/conf.d/test1.conf
```

## 3. Kiểm tra:
**Truy cập:** http://192.168.30.72

- Kết quả:

![](../image/kqproxy1.png)

**Truy cập:** http://192.168.30.72/cong

- Kết quả:
![](./../image/kqproxy2.png)

# Tài liệu tham khảo

1. https://serverfault.com/questions/618889/can-you-define-a-servers-locations-in-multiple-nginx-config-files
