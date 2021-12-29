# Chapter 43: Pipelines - Đường ống

## 43.1: Sử dụng |& - Using |&

|& kết nối đầu ra tiêu chuẩn và lỗi tiêu chuẩn của lệnh đầu tiên với lệnh thứ hai trong khi | chỉ kết nốiđầu ra tiêu chuẩn của lệnh đầu tiên đến lệnh thứ hai.

Trong ví dụ này, trang được tải xuống qua curl . với tùy chọn -v curl viết một số thông tin trên stderr bao gồm,trang tải xuống được viết trên stdout . Tiêu đề của trang có thể được tìm thấy giữa <title> và </title> .

```
curl -vs 'http://www.google.com/' |& awk '/Host:/{print}
/<title>/{match($0,/<title>(.*)<\/title>/,a);print a[1]}'
```

Đầu ra là:

```
> Host: www.google.com
Google
```

Nhưng với | nhiều thông tin hơn sẽ được in ra, tức là những thông tin được gửi đến stderr vì chỉ stdout được chuyển đếnlệnh tiếp theo. Trong ví dụ này, tất cả các dòng ngoại trừ dòng cuối cùng (Google) đã được gửi đến stderr theo curl :

```
* Hostname was NOT found in DNS cache
* Trying 172.217.20.228...
* Connected to www.google.com (172.217.20.228) port 80 (#0)
> GET / HTTP/1.1
> User-Agent: curl/7.35.0
> Host: www.google.com
> Accept: */*
>
* HTTP 1.0, assume close after body
< HTTP/1.0 200 OK
< Date: Sun, 24 Jul 2016 19:04:59 GMT
< Expires: -1
< Cache-Control: private, max-age=0
< Content-Type: text/html; charset=ISO-8859-1
< P3P: CP="This is not a P3P policy! See
https://www.google.com/support/accounts/answer/151657?hl=en for more info."
< Server: gws
< X-XSS-Protection: 1; mode=block
< X-Frame-Options: SAMEORIGIN
< Set-Cookie: NID=82=jX0yZLPPUE7u13kKNevUCDg8yG9Ze_C03o0IMEopOSKL0mMITEagIE816G55L2wrTlQwgXkhq4ApFvvYEoaWFoEoq2T0sBTuQVdsIFULj9b2O8X35O0sAgUnc3a3JnTRBqelMcuS9QkQA; expires=Mon, 23-Jan-2017 19:04:59 GMT;
path=/; domain=.google.com; HttpOnly
< Accept-Ranges: none
< Vary: Accept-Encoding
< X-Cache: MISS from jetsib_appliance
< X-Loop-Control: 5.202.190.157 81E4F9836653D5812995BA53992F8065
< Connection: close
<
{ [data not shown]
* Closing connection 0
Google
```

## 43.2: Hiển thị tất cả các quy trình được phân trang - Show all processes paginated

```
ps -e | less
```

`ps -e` hiển thị tất cả các quá trình, đầu ra của nó được kết nối với đầu vào của nhiều hơn thông qua | , `less` phân trang kết quả hơn.

## 43.3: Sửa đổi đầu ra liên tục của một lệnh - Modify continuous output of a command

```
~$ ping -c 1 google.com # unmodified output
PING google.com (16.58.209.174) 56(84) bytes of data.
64 bytes from wk-in-f100.1e100.net (16.58.209.174): icmp_seq=1 ttl=53 time=47.4 ms
~$ ping google.com | grep -o '^[0-9]\+[^()]\+' # modified output
64 bytes from wk-in-f100.1e100.net
64 bytes from wk-in-f100.1e100.net
64 bytes from wk-in-f100.1e100.net
64 bytes from wk-in-f100.1e100.net
64 bytes from wk-in-f100.1e100.net
64 bytes from wk-in-f100.1e100.net
64 bytes from wk-in-f100.1e100.net
64 bytes from wk-in-f100.1e100.net
64 bytes from wk-in-f100.1e100.net
64 bytes from wk-in-f100.1e100.net
...
```

Các ống (|) kết nối các thiết bị xuất chuẩn của `ping` đến stdin của `grep` , mà xử lý nó ngay lập tức. Vài người khác các lệnh như `sed` mặc định để đệm stdin của chúng , có nghĩa là nó phải nhận đủ dữ liệu, trước khi nóin bất cứ thứ gì, có thể gây ra sự chậm trễ trong quá trình xử lý tiếp theo.