# Lệnh cURL trong Linux

Mục lục
- [Lệnh cURL trong Linux](#lệnh-curl-trong-linux)
  - [1. Tổng quan](#1-tổng-quan)
  - [2. Cú pháp:](#2-cú-pháp)
  - [3. Một số option của cURL](#3-một-số-option-của-curl)

## 1. Tổng quan
- cURL là viết tắt của từ **Client for URLs**
- cURL là một công cụ dòng lệnh để truyền dữ liệu bằng URL (Uniform Resource Locator).
- hỗ trợ nhiều giao thức: FTP, FTPS, HTTP, HTTPS, IMAP, SMTP, v.v.
- không có giao diện.

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

lấy thông tin header từ một website bằng curl:
```
curl -I www.testdomain.com
```
Lấy thông tin 