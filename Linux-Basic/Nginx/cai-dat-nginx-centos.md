<h1> Hướng dẫn cài đặt Nginx trên Centos 7 </h1>

Nginx Open Source có 2 version:
- Mainline - Bao gồm các tính năng và bản vá mới nhất, luôn được cập nhật, đáng tin cậy. Nhưng có thể bao gồm 1 số mô-đun thử nghiệm và có thể có 1 số lỗi mới.
- Stable - Không có các tính năng mới nhất, nhưng luôn có các bản vá quang trọng. Đề xuất cho `production servers`.

![](./image/NGINX-logo.png)

<h2>Mục lục</h2>

- [Khởi tạo Nginx Repo](#1-khởi-tạo-nginx-repo)
- [Thực hiện cài đặt NGINX](#2-thực-hiện-cài-đặt-nginx)
- [Khởi động Nginx web server và đặt tự động khởi động dịch vụ khi server được bật](#3-khởi-động-nginx-web-server-và-đặt-tự-động-khởi-động-dịch-vụ-khi-server-được-bật)
- [Tài liệu tham khảo](#tài-liệu-tham-khảo)

## 1. Khởi tạo Nginx Repo
Thiết lập kho lưu trữ cho Centos bằng cách tạo tệp `nginx.repo` trong `/etc/yum.repos.d`

```
echo '#/etc/yum.repos.d/nginx.repo
[nginx]
name= nginx repo
baseurl=https://nginx.org/packages/mainline/<OS>/<OSRELEASE>/$basearch/
gpgcheck=0
enabled=1' > /etc/yum.repos.d/nginx.repo
```

Trong đó:
- `/mainline` trong `baseurl` trỏ đến phiên bản mới nhất của NGINX Open Source; xoá nó để tải về bản `Stable`
- `<OS>` là 1 trong 2:
  - `rhel`
  - `centos`
- `<OSRELEASE>` là số phiên bản. Ví dụ:
  - `6`
  - `6._x_`
  - `7`
  - `7._x_`
  - ...
- Ví dụ: để tải phiên bản `Stable` cho `Centos 7`:
```
echo '#/etc/yum.repos.d/nginx.repo
[nginx]
name= nginx repo
baseurl=https://nginx.org/packages/centos/7/$basearch/
gpgcheck=0
enabled=1' > /etc/yum.repos.d/nginx.repo
```

## 2. Thực hiện cài đặt NGINX

Cập nhật thông tin mới nhất cho repo:
```
yum update -y
```

Bắt đầu cài đặt Nginx Open Source
```
yum install nginx -y
```
## 3. Khởi động Nginx web server và đặt tự động khởi động dịch vụ khi server được bật

Khởi động Nginx:
```
systemctl start nginx
```

Dừng Nginx:
```
systemctl stop nginx
```
Set tự động khởi động dịch vụ khi server được bật:
```
systemctl enable nginx
```
Set tắt tự động khởi động dịch vụ khi server được bật:
```
systemctl disable nginx
```

Kiểm tra Nginx đã hoạt động chưa:
```
systemctl nginx status
```
hoặc
```
curl -I 127.0.0.1
#kết quả:
HTTP/1.1 200 OK
Server: nginx/1.20.2
```
Kiểm tra version:
```
nginx -v
```

Lưu ý: Nếu xuất hiện lỗi:`nginx[75718]: nginx: [emerg] bind() to 0.0.0.0:80 failed (98: Address already in use)
`
- Có nghĩa là có 1 dịch vụ khác đang chạy trên cùng một cổng. (Không thể có nhiều dịch vụ cùng nghe trên cùng 1 cổng)
- Dịch vụ đã nghe trên cổng 80 có thể là Apache hoặc bất kỳ máy chủ web nào khác đang nghe trên cổng 80.
- Để kiểm tra:
```
netstat -plant | grep 80
```
- Để khởi động có thể thay đổi port trên Nginx (xem [tại đây](Cau-hinh-port.md)) hoặc dừng dịch vụ đang chạy trên port 80.

## 4. Cấu hình firewall:
Cho phép port 80:
```
firewall-cmd --zone=public --permanent --add-port=80/tcp
```
Cho phép port 443 và có thể cho phép các port khác.
```
firewall-cmd --zone=public --permanent --add-port=443/tcp
```


Cuối cùng Reload lại firewalld:
```
firewall-cmd --reload
```
# Tài liệu tham khảo

1. https://docs.nginx.com/nginx/admin-guide/installing-nginx/installing-nginx-open-source/