# Cài đặt và cấu hình Mariadb

**Mục lục**
- [Cài đặt và cấu hình Mariadb](#cài-đặt-và-cấu-hình-mariadb)
  - [1. Cài đặt MariaDB 5.5](#1-cài-đặt-mariadb-55)
  - [2. Cài đặt bảo mật cho MariaDB](#2-cài-đặt-bảo-mật-cho-mariadb)
  - [3.Kết nối Mariadb bằng root](#3kết-nối-mariadb-bằng-root)
  - [4. Cấu hình firewall](#4-cấu-hình-firewall)
  - [Câu lệnh SQL cơ bản sử dụng máy chủ MariaDB](#câu-lệnh-sql-cơ-bản-sử-dụng-máy-chủ-mariadb)
  - [6. File log](#6-file-log)
- [Tài liệu tham khảo](#tài-liệu-tham-khảo)

## 1. Cài đặt MariaDB 5.5
- Cài đặt:

`# yum -y install mariadb-server`

![](image/install.png)

- Cấu hình chuẩn utf8

```
# vi /etc/my.cnf
[mysqld]
character-set-server=utf8
```

- Khởi động dịch vụ:

```
# systemctl start mariadb
# systemctl enable mariadb
```

![](image/start.png)

## 2. Cài đặt bảo mật cho MariaDB

- Câu lệnh:

``# mysql_secure_installation``

- Nhập mật khẩu root hiện tại (Nếu lần đầu nhấn Enter)

![](image/setting.png)

- Cài đặt mật khẩu cho root:

![](image/setroot.png)

- Remove người dùng ẩn danh:
  
![](image/xoanguoidungandanh.png)

- Không cho phép login root từ xa và Remove test database:

![](image/tuxa_xoatest.png)

- Reload privilege table: Áp dụng cấu hình vừa đặt ở trên

![](image/table.png)

## 3.Kết nối Mariadb bằng root
- Câu lệnh:

```# mysql -u root -p```
- Nhập mật khẩu đã đặt ở bước 2

![](../image/connect.png)



## 4. Cấu hình firewall
- MariaDB có thể được sử dụng từ các Máy chủ từ xa.
- MariaDB sử dụng 3306 / TCP.
- Cho phép dịch vụ qua firewall:

``#irewall-cmd --add-service=mysql --permanent``
``#firewall-cmd --reload``

![](image/firewall.png)

## Câu lệnh SQL cơ bản sử dụng máy chủ MariaDB
- Đăng nhập vào MariaDB với tài khoản root:

```# mysql -u root -p ```

- Hiển thị toàn bộ users:

```select user,host from mysql.user;```

Output:
![](image/showuser.png)

- Đổi tên tài khoản root (bảo mật):

 ```UPDATE mysql.user SET user="admindb" WHERE user="root"; ```

Kết quả:

![](image/admindb.png)

- Tạo database

``` create database [name];```
Ex: create database ql;

- Xem danh sách database hiện có:

 show databases; 

![](image/taodb.png)

- Truy cập vào cơ sở dữ liệu:

``` use  [database_name]; ```

- Tạo bảng:

```create  table [table name](các trường);```

Ex:

use ql;
 create table nhanvien(
  manv int not null auto_increment,
  ho varchar(100) not null,
  ten varchar(100) not null,
  tuoi int not null,
  diachi varchar(200) not null,
  primary key (manv)
  ); 

![](image/taobang.png)

- Hiển thị toàn bộ table hiện có

 ```show tables;``` 

![](image/showbang.png)

- Xóa bảng:

```drop table  [tên bảng];``` 

## 6. File log
- Folder mặc định:

```#cd /var/log/mariadb ```

- Giám sát hoạt động trên file log:

```# tail -f /var/log/mariadb/mariadb.log```

![](image/log.png)

# Tài liệu tham khảo
1. https://www.server-world.info/en/note?os=CentOS_7&p=mariadb&f=1