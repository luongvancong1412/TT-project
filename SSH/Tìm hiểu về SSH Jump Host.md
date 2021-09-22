# Tìm hiểu về SSH Jump Host


Mục tiêu:
- Hiểu về SSH Jump Host và sử dụng ProxyJump
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
## ProxyJump


Tài liệu tham khảo:
1. https://en.wikipedia.org/wiki/Jump_server