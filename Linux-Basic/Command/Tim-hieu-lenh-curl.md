# Lệnh cURL trong Linux

Mục lục

- [Lệnh cURL trong Linux](#lệnh-curl-trong-linux)
  - [1. Tổng quan](#1-tổng-quan)
  - [2. Cú pháp:](#2-cú-pháp)
  - [3. Một số option của cURL](#3-một-số-option-của-curl)
    - [3.1 Tải xuống 1 file (-O giữ nguyên tên, -o đổi tên)](#31-tải-xuống-1-file--o-giữ-nguyên-tên--o-đổi-tên)
    - [3.2 Tải xuống 1 file và xác thực HTTP (-u)](#32-tải-xuống-1-file-và-xác-thực-http--u)
    - [3.2 Tải xuống tệp với 1 proxy (-x)](#32-tải-xuống-tệp-với-1-proxy--x)
    - [3.2 Tải  1 file từ FTP server có xác thực:](#32-tải--1-file-từ-ftp-server-có-xác-thực)
    - [3.3 Upload 1 file lên FTP server có xác thực (-T)](#33-upload-1-file-lên-ftp-server-có-xác-thực--t)
    - [3.4 Dùng FTP lấy danh sách thư mục](#34-dùng-ftp-lấy-danh-sách-thư-mục)
    - [3.5 Tiếp tục quá trình tải xuống không thành công hoặc bị huỷ trước đó](#35-tiếp-tục-quá-trình-tải-xuống-không-thành-công-hoặc-bị-huỷ-trước-đó)
    - [3.6 Lấy thông tin header từ một website (-I):](#36-lấy-thông-tin-header-từ-một-website--i)
    - [3.7 Giới hạn tốc độ tải xuống (--limit-rate)](#37-giới-hạn-tốc-độ-tải-xuống---limit-rate)
    - [3.8 POST request, ví dụ với 1 API (--date or -d cho HTTP post ; -X POST cho option request)](#38-post-request-ví-dụ-với-1-api---date-or--d-cho-http-post---x-post-cho-option-request)
    - [3.9 Xem thời tiết địa phương:](#39-xem-thời-tiết-địa-phương)
    - [3.10 Xem địa chỉ IP public của bạn](#310-xem-địa-chỉ-ip-public-của-bạn)
- [Tài liệu tham khảo](#tài-liệu-tham-khảo)

## 1. Tổng quan
- cURL là viết tắt của từ **Client for URLs**
- cURL là một công cụ dòng lệnh để lấy hoặc gửi dữ liệu và tệp bằng URL (Uniform Resource Locator).
- Hỗ trợ nhiều giao thức: FTP, FTPS, HTTP, HTTPS, IMAP, SMTP, v.v.
- không có giao diện.
- cURL phát hành đầu tiên vào năm 1997 và có tên là `httpget`, sau đó đổi tên thành `urlget` trước khi sử dụng tên hiện tại.
- Tác giả và nhà phát triển là Daniel Stenberg (Người Thuỵ Điển).
Kiểm tra phiên bản cURL:
```
curl --version
```

Out:
```
[root@localhost ~]# curl --version
curl 7.29.0 (x86_64-redhat-linux-gnu) libcurl/7.29.0 NSS/3.36 zlib/1.2.7 libidn/1.28 libssh2/1.4.3
Protocols: dict file ftp ftps gopher http https imap imaps ldap ldaps pop3 pop3s rtsp scp sftp smtp smtps telnet tftp
Features: AsynchDNS GSS-Negotiate IDN IPv6 Largefile NTLM NTLM_WB SSL libz unix-sockets
```
## 2. Cú pháp:

```
curl [Options] [URL]
```

Để xem các option của cURL sử dụng lệnh
```
curl --help
```
hoặc
```
man curl
```

Cách dùng đơn giản nhất của Curl là hiển thị nội dung của trang:
```
[root@localhost ~]# curl congvhost2.world
<DOCTYPE html>
<html>
<head>
<title>www.congvhost2.world</title>
</head>
<body>
<h1>Luong Van Cong</h1>
<h1>Virtual host 2</h1>
</body>
</html>
```

Nếu không xác định protocol thì curl mặc định là HTTP.

## 3. Một số option của cURL

### 3.1 Tải xuống 1 file (-O giữ nguyên tên, -o đổi tên)
Tải file từ một máy chủ từ xa:
- -O sẽ lưu file trong cùng thư mục hiện hành với tên file giống với tên file từ xa.
- -o giúp chọn tên file và đường dẫn của file
```
curl -O http://testdomain.com/testfile.tar.gz
```
Lệnh trên sẽ lưu file thành testfile.tar.gz.
```
curl -o newtestfile.tar.gz http://testdomain.com/testfile.tar.gz
```
Lệnh trên sẽ lưu file thành newtestfile.tar.gz.

Tải nhiều tệp cũng lúc (tên giữ nguyên):
```
curl -O http://example.com/first-file.xyz -O http://anothersite.com/second-file.xyz -O http://site3.com/file.xyz
```

### 3.2 Tải xuống 1 file và xác thực HTTP (-u)
```
curl -u username:password URL
```
### 3.2 Tải xuống tệp với 1 proxy (-x)
```
curl -x proxysever.example.com:PORT http://address-i-want-to.access
```
### 3.2 Tải  1 file từ FTP server có xác thực:
```
curl -u username:password -O ftp://example.com/pub/file.zip
```
### 3.3 Upload 1 file lên FTP server có xác thực (-T)
```
curl -u username:password -T image.png ftp://ftp.example.com/images/
```
### 3.4 Dùng FTP lấy danh sách thư mục
```
curl ftp://username:password@example.com
```
### 3.5 Tiếp tục quá trình tải xuống không thành công hoặc bị huỷ trước đó
```
curl -C - -o partial_file.zip http://example.com/file.zip
```
### 3.6 Lấy thông tin header từ một website (-I):
```
curl -I www.testdomain.com
```
Lệnh này hữu ích để kiểm tra trạng thái trang web
### 3.7 Giới hạn tốc độ tải xuống (--limit-rate)
```
curl --limit-rate 100B -O http://example.com/file
```
### 3.8 POST request, ví dụ với 1 API (--date or -d cho HTTP post ; -X POST cho option request)
```
curl --data -X POST "param1=value1" https://example.com/api
```
Ví dụ gửi tin nhắn tới Telegram:
```
curl -d chat_id=<chat_id> -d text="noi_dung"  https://api.telegram.org/bot<token>/sendMessage
```
### 3.9 Xem thời tiết địa phương:
```
curl wtt.in/Hanoi
```
### 3.10 Xem địa chỉ IP public của bạn
```
curl ifconfig.me
```

# Tài liệu tham khảo

1. https://en.wikipedia.org/wiki/CURL
2. https://aboutnetworks.net/linux-networking-part-4/
3. https://curl.se/