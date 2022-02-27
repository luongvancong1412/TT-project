# [Bash Shell] Reload lại trang URL với số lần nhập từ bàn phím

Mục lục

- [[Bash Shell] Reload lại trang URL với số lần nhập từ bàn phím](#bash-shell-reload-lại-trang-url-với-số-lần-nhập-từ-bàn-phím)
  - [1. Script Reload lại trang URL](#1-script-reload-lại-trang-url)
  - [2. Phân quyền cho script](#2-phân-quyền-cho-script)
  - [3. Chạy script](#3-chạy-script)
- [Tài liệu tham khảo:](#tài-liệu-tham-khảo)

## 1. Script Reload lại trang URL
Đoạn script sẽ thực hiện công việc Reload 1 trang URL với số lần Reload nhập từ bàn phím trên Centos 7 và trả về Mã trạng thái của trang web:

Tạo 1 script backup có đường dẫn: **/scripts/Reload_url.sh**

```
#! /bin/bash
echo "Nhap url trang web:"
read url

echo "Nhap so lan tai lai trang nay:"
read solan

for ((i=0;i<$solan;i++));do
	HTTP_CODE=$(curl --write-out "%{http_code}\n" $url --output output.txt --silent)
	echo "Lan $((i+1)) : $HTTP_CODE" 
done
```

Trong đó:
- `#! /bin/bash` được gọi là shebang, nó cho shell biết tập lệnh sẽ được biên dịch và chạy bởi bash shell.
- `HTTP_CODE` là mã trạng thái của URL.
- 

## 2. Phân quyền cho script
Sử dụng lệnh:
```
chmod +x /scripts/Reload_url.sh
```
## 3. Chạy script
Chạy script bằng lệnh sau
```
cd /scripts
bash Reload_url.sh
```

Output:
```
[root@localhost ~]# bash Reload_url.sh
Nhap url trang web:
congvhost1.world
Nhap so lan tai lai trang nay:
15
Lan 1 : 200
Lan 2 : 200
Lan 3 : 200
Lan 4 : 200
Lan 5 : 200
Lan 6 : 200
Lan 7 : 200
Lan 8 : 503
Lan 9 : 503
Lan 10 : 503
Lan 11 : 503
Lan 12 : 503
Lan 13 : 503
Lan 14 : 503
Lan 15 : 503
```
Mã :200 OK - kết nối thành công
Mã :`503 (Service Temporarily Unavailable)`- dịch vụ tạm thời không khả dụng
# Tài liệu tham khảo:

1. https://codefather.tech/blog/curl-bash-script/