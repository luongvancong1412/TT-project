# Chapter 46: Avoiding date using printf - Tránh ngày sử dụng printf

Trong Bash 4.2, một vỏ built-in chuyển đổi thời gian cho printf được giới thiệu: thông số định dạng % ( datefmt ) T làm choprintf xuất ra chuỗi ngày-giờ tương ứng với chuỗi định dạng datefmt theo cách hiểu của strftime.

## 46.1: Lấy ngày hiện tại - Get the current date

```
$ printf '%(%F)T\n'
2016-08-17
```

## 46.2: Đặt biến thành thời gian hiện tại - Set variable to current time

```
$ printf -v now '%(%T)T'
$ echo "$now"
12:42:47
```