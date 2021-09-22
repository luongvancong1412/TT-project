# Tìm hiểu về SSH Jump Host


Mục tiêu:
- Hiểu về SSH Jump Host
- Kết nối an toàn sử dụng OpenSSH ProxyJump

## A Jump Host
- A Jump Host (Máy chủ nhảy)là một hệ thống trên mạng được sử dụng để truy cập và quản lý các thiết bị trong một vùng bảo mật riêng biệt.  
- A Jump Host là a hardened server được đặt giữa các zone (vùng) bảo mật khác nhau.
- Các vùng bảo mật này có thể là:
  - Máy chủ trong DMZ của một công ty
  - Truy cập mạng của gia đình từ xa
  - VPN
- Các máy chủ jump hardening (hạn chế bề mặt mối đe doạ) bằng:
  - Hạn chế số lượng cổng đang mở
  - Sử dụng ssh (Secure Shell)
  - Triển khai tường lửa (Enable firewall)
  - Vá lỗi hệ thống thường xuyên

## Cấu hình SSH Jump Host
### Mô hình mạng

![](SSH%20Jump%20Host/image/mhm.png)
### Cấu hình SSH Jump Host
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

Thực hiện kết nối tới server:
```
#ssh server
```
Hình minh hoạ:

![](SSH%20Jump%20Host/image/kq.png)


Tài liệu tham khảo:
1. https://en.wikipedia.org/wiki/Jump_server
2. https://www.simplified.guide/ssh/jump-host
3. https://blog.ajiarya.id/posts/linux/cara-ssh-jump/#panduan