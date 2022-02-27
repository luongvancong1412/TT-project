# Cấu hình Nginx làm Reverse Proxy cho Nginx. 



## 1. Mô hình mạng

![](./../NTP/image/nginxproxynginx.png)

![](./../NTP/image/ipnginxfornginx.png)

## 2. Các bước thực hiện

### 1. Cài đặt Web server: Nginx

> Thực hiện trên node 1 và node 2

Install the prerequisites:
```
yum install yum-utils -y
```
Thêm repo:

```
echo '[nginx-stable]
name=nginx stable repo
baseurl=http://nginx.org/packages/centos/$releasever/$basearch/
gpgcheck=1
enabled=1
gpgkey=https://nginx.org/keys/nginx_signing.key
module_hotfixes=true

[nginx-mainline]
name=nginx mainline repo
baseurl=http://nginx.org/packages/mainline/centos/$releasever/$basearch/
gpgcheck=1
enabled=0
gpgkey=https://nginx.org/keys/nginx_signing.key
module_hotfixes=true' >> /etc/yum.repos.d/nginx.repo
```
use mainline nginx packages:
```
yum-config-manager --enable nginx-mainline
```
install nginx:
```
yum install nginx -y
```

Cấu hình firewall:
```
firewall-cmd --zone=public --permanent --add-port=80/tcp
firewall-cmd --zone=public --permanent --add-port=443/tcp
firewall-cmd --reload
```
Khởi động dịch vụ:
```
systemctl start nginx
systemctl enable nginx
```

> Trên node 1:
Tạo 1 trang web đơn giản
```
vi /usr/share/nginx/html/index.html
```
Cấu hình:
```
<!DOCTYPE html>
<html>
<head>
<title>Luong Van Cong</title>
<style>
html { color-scheme: light dark; }
body { width: 35em; margin: 0 auto;
font-family: Tahoma, Verdana, Arial, sans-serif; }
</style>
</head>
<body>
<h1>Nginx server 1</h1>
</body>
</html>
```
> Tương tự trên node 2

Tạo 1 trang web đơn giản
```
vi /usr/share/nginx/html/index.html
```
Cấu hình:
```
<!DOCTYPE html>
<html>
<head>
<title>Luong Van Cong</title>
<style>
html { color-scheme: light dark; }
body { width: 35em; margin: 0 auto;
font-family: Tahoma, Verdana, Arial, sans-serif; }
</style>
</head>
<body>
<h1>Nginx server 2</h1>
</body>
</html>
```


### 3.Cài đặt Nginx

> Trên node 3

Install the prerequisites:
```
yum install yum-utils -y
```
Thêm repo:

```
echo '[nginx-stable]
name=nginx stable repo
baseurl=http://nginx.org/packages/centos/$releasever/$basearch/
gpgcheck=1
enabled=1
gpgkey=https://nginx.org/keys/nginx_signing.key
module_hotfixes=true

[nginx-mainline]
name=nginx mainline repo
baseurl=http://nginx.org/packages/mainline/centos/$releasever/$basearch/
gpgcheck=1
enabled=0
gpgkey=https://nginx.org/keys/nginx_signing.key
module_hotfixes=true' >> /etc/yum.repos.d/nginx.repo
```
use mainline nginx packages:
```
yum-config-manager --enable nginx-mainline
```
install nginx:
```
yum install nginx -y
```

Cấu hình firewall:
```
firewall-cmd --zone=public --permanent --add-port=80/tcp
firewall-cmd --zone=public --permanent --add-port=443/tcp
firewall-cmd --reload
```
Khởi động dịch vụ:
```
systemctl start nginx
systemctl enable nginx
```
Backup file cấu hình `/etc/nginx/nginx.conf`
```
cp /etc/nginx/nginx.conf /etc/nginx/nginx.conf.bak
```

Tạo 1 block server trong block http của tệp /etc/nginx/nginx.conf
```
server {
        server_name www.hostcong.world hostcong.world;
        listen      [::]:80;
        listen      80;

        include /etc/nginx/conf.d/*.conf;
}
```
Tạo 1 file `cong1.world.conf` trong thư mục : `/etc/nginx/conf.d/` cho trang web thứ 1.
```
echo 'location / {

        proxy_redirect           off;
        proxy_set_header         X-Real-IP $remote_addr;
        proxy_set_header         X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header         Host $http_host;

        proxy_pass http://192.168.77.70/;

}' >> /etc/nginx/conf.d/cong1.world.conf
```

Tạo thêm 1 file `cong2.world.conf` trong thư mục : `/etc/nginx/conf.d/` cho trang web thứ 2.
```
echo 'location /cong {

        proxy_redirect           off;
        proxy_set_header         X-Real-IP $remote_addr;
        proxy_set_header         X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header         Host $http_host;

        proxy_pass http://192.168.77.71/;

}' >> /etc/nginx/conf.d/cong2.world.conf
```

Kiểm tra cú pháp (syntax) cấu hình:
```
nginx -t
```

Kết quả:
```
[root@node3 ~]# nginx -t
nginx: the configuration file /etc/nginx/nginx.conf syntax is ok
nginx: configuration file /etc/nginx/nginx.conf test is successful
```

Khởi động lại dịch vụ:
```
nginx -s reload
```
hoặc
```
systemctl restart nginx
```

Câu lệnh kết hợp:
```
nginx -t && nginx -s reload
```

### 5. Kiểm tra:
**Truy cập:** http://hostcong.world

- Kết quả:


**Truy cập:** http://hostcong.world/cong

# Tài liệu tham khảo:

1. https://www.server-world.info/en/note?os=CentOS_7&p=nginx&f=6
2. https://docs.nginx.com/nginx/admin-guide/web-server/reverse-proxy/