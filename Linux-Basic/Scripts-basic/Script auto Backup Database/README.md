# [Bash Script] Script tự động Backup Database mariadb


## 1.Script tự động backup

Đoạn script sẽ thực hiện công việc tự động Backup Database (MariaDB) hàng ngày trên Linux Server sử dụng Crontab

Tạo 1 script backup có đường dẫn: **/scripts/backup.sh**

```
#! /bin/bash

#Các tham số sử dụng
TIME=$(date +"%H%M%S-%d%m%Y")
DBNAME=quanly
DBUSER=admindb
PASSWD=123456

#Lệnh backup
cd /backup
mysqldump -u $DBUSER -p$PASSWD $DBNAME > $DBNAME-$TIME.sql
```

Trong đó:
- `/backup` là thư mục lưu trữ các bản backup
- `$TIME` là biến sử dụng để ghi thời gian tạo file backup
- `$DBNAME` là tên của Database
- `$DBUSER` là tên của User Mariadb Database
- `$PASSWD` là mật khẩu của $DBUSER

Phân quyền thực thi cho script backup:
```
chmod +x /scripts/backup.sh
```

## 2.Thiết lập Crontab để tự động backup hàng ngày
Thực hiện lệnh: `crontab -e` trên server để thiết lập 1 cron tự động backup hàng ngày

```
#Thực thi lệnh vào lúc 23h59' hàng ngày
59 23 * * * /scripts/backup.sh
```
Đoạn script sẽ tự động được chạy bởi Crontab lúc 23:59 hàng ngày theo múi giờ thiết lập trên server