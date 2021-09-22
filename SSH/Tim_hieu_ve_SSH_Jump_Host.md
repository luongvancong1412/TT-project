# Tìm hiểu về SSH Jump Host

## Mục lục

  - [1.A Jump Host](#1a-jump-host)
  - [2. Cấu hình SSH Jump Host](#2-cấu-hình-ssh-jump-host)
    - [2.1 Mô hình mạng](#21-mô-hình-mạng)
    - [2.2 Cấu hình SSH Jump Host](#22-cấu-hình-ssh-jump-host)
    - [2.3 Thực hiện kết nối tới máy chủ](#23-thực-hiện-kết-nối-tới-máy-chủ)
    - [2.4 Kết nối tới máy chủ không cần cấu hình](#24-kết-nối-tới-máy-chủ-không-cần-cấu-hình)
  - [Tài liệu tham khảo](#tài-liệu-tham-khảo)

**Mục tiêu:**
- Hiểu về SSH Jump Host
- Kết nối sử dụng OpenSSH ProxyJump

## 1.A Jump Host
- A Jump Host (Máy chủ nhảy) là một hệ thống trên mạng được sử dụng để truy cập và quản lý các thiết bị trong một vùng bảo mật riêng biệt.
- Máy chủ nhảy là một máy chủ cứng và được giám sát trải dài hai vùng bảo mật khác nhau và cung cấp phương tiện truy cập được kiểm soát giữa chúng
- Nó là một máy chủ mà người dùng có thể đăng nhập vào và sử dụng như một máy chủ chuyển tiếp để kết nối đến các máy chủ Linux khác, router,...
- Các vùng bảo mật này có thể là:
  - Máy chủ trong DMZ của một công ty
  - Truy cập mạng của gia đình từ xa
  - Sử dụng VPN
- Các máy chủ jump hardening (hạn chế bề mặt mối đe doạ) bằng:
  - Hạn chế số lượng cổng đang mở
  - Sử dụng ssh (Secure Shell)
  - Triển khai tường lửa (Enable firewall)
- Giám sát đăng nhập trên SSH Jump Host
```
#tail -f /var/log/secure
```

![](SSH%20Jump%20Host/image/gsatdangnhap.png)
## 2. Cấu hình SSH Jump Host
### 2.1 Mô hình mạng

![](SSH%20Jump%20Host/image/mhm.png)
### 2.2 Cấu hình SSH Jump Host
Trên Client: Mở tệp cấu hình SSH 
```
#vi ~/.ssh/config
```
Cấu hình thông tin máy chủ:
```
#Máy trung gian
Host proxy
        hostname 192.168.100.128
        user user1

#Máy đích
host server
        hostname 192.168.100.135
        user user1
        proxyjump proxy
```
Hình minh hoạ:

![](SSH%20Jump%20Host/image/configproxyjump.png)

### 2.3 Thực hiện kết nối tới máy chủ
```
#ssh server
```
Hình minh hoạ:

![](SSH%20Jump%20Host/image/kq.png)

### 2.4 Kết nối tới máy chủ không cần cấu hình
```
#ssh -J user1@192.168.100.128 user1@192.168.100.135
```
Hình minh hoạ:

![](SSH%20Jump%20Host/image/kconfig.png)

## Tài liệu tham khảo
1. https://en.wikipedia.org/wiki/Jump_server
2. https://www.simplified.guide/ssh/jump-host
3. https://blog.ajiarya.id/posts/linux/cara-ssh-jump/#panduan