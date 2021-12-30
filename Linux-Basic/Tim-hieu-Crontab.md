# Tìm hiểu Crontab

- [Tìm hiểu Crontab](#tìm-hiểu-crontab)
  - [I. Tổng quan về crontab](#i-tổng-quan-về-crontab)
    - [1. Khái niệm](#1-khái-niệm)
    - [2. Cài đặt Crontab:](#2-cài-đặt-crontab)
    - [3. Định dạng Cron table](#3-định-dạng-cron-table)
    - [4. Cách sử dụng](#4-cách-sử-dụng)
  - [II. Ứng dụng](#ii-ứng-dụng)
  - [Tài liệu tham khảo](#tài-liệu-tham-khảo)

## I. Tổng quan về crontab
### 1. Khái niệm
- Cron là một tiện ích cho phép chạy các dòng lệnh theo một chu kì thời gian nào đó. Crond là một daemon process, điều này cho phép nó chạy ngầm mãi mãi trong hệ thống linux.

- Crontab (hay Crontable) là bảng chứa các câu lệnh cài đặt của cron. Nhờ có crontab, ta có thể sử dụng để có thể chạy những công việc tự động theo một lịch trình cụ thể đã cài đặt từ trước.
### 2. Cài đặt Crontab:
- Sử dụng lệnh:

```
yum install cronie
```

- Start crontab và tự động chạy mỗi khi khởi động:
```
systemctl start crond
systemctl enable crond
```
### 3. Định dạng Cron table
- Một crontab file có 5 trường xác định thời gian, cuối cùng là lệnh sẽ được chạy định kỳ, cấu trúc như sau:
```
*    *    *   *    *  Command_to_execute
|    |    |    |   |       
|    |    |    |    Day of the Week ( 0 - 6 ) ( Sunday = 0 )
|    |    |    |
|    |    |    Month ( 1 - 12 )
|    |    |
|    |    Day of Month ( 1 - 31 )
|    |
|    Hour ( 0 - 23 )
|
Min ( 0 - 59 )
```

- Dấu "*" đại diện cho mỗi đơn vị thời gian .(Nếu như dấu * nằm ở vị trí là phút thì mỗi phút kích hoạt)
    - Cột 1: định nghĩa theo phút. có thể gán từ 0 -59
    - Cột 2: định nghĩa theo giờ. Có thể gán từ 0 - 23
    - Côt 3: định nghĩa theo ngày. có thể gán từ 0 -31
    - Cột 4: định nghĩa theo tháng. (1 - 12)
    - Cột 5: định nghĩa theo ngày trong tuần (Sun, Mon, Tue, ...)
    - Cột 6: user thực thi lệnh
    - Cột 7: Lệnh được thực thi
### 4. Cách sử dụng
- Một cron schedule đơn giản là một text file. 
- Crontab có thể thực thi ở 2 mức đỘ:
  - Per-User: Mỗi một user có thể định nghĩa 1 tiến trình crontab
  - System-Wide: địn nghĩa crontab ở mức độ hệ thống
- 
- Một số lệnh thường dùng:
  - Tạo hoặc chỉnh sửa file crontab
  ```
  crontab -e
  ```
  - Hiển thị file crontab
  ```
  crontab -l
  ```
  - xoá file crontab
  ```
  crontab -r
  ```
- Cấu hình crontab cho user:
  - Đăng nhập vào user cần tạo:
  - Nhập lệnh : `crontab -e`
    ```
    su user
    crontab -e
    ```
  - Nhập lệnh và thời gian thực thi
    ```
    00 03 * * * /root/Taofile/backup.sh
    ```
  - Lưu lại

- Cấu hình crontab cho System-wide:Cấu hình trong file
  - Sử dụng lệnh
    ```
    vi /etc/crontab
    ```
  - Output:
    ```
    SHELL=/bin/bash
    PATH=/sbin:/bin:/usr/sbin:/usr/bin
    MAILTO=root

    # For details see man 4 crontabs

    # Example of job definition:
    # .---------------- minute (0 - 59)
    # |  .------------- hour (0 - 23)
    # |  |  .---------- day of month (1 - 31)
    # |  |  |  .------- month (1 - 12) OR jan,feb,mar,apr ...
    # |  |  |  |  .---- day of week (0 - 6) (Sunday=0 or 7) OR sun,mon,tue,wed,thu,fri,sat
    # |  |  |  |  |
    # *  *  *  *  * user-name  command to be executed
    ```
  - Nhập lệnh và lưu lại
- Một số file khác
```
[root@conglv etc]# ls -l cron*
-rw-------. 1 root root   0 Aug  9  2019 cron.deny # Lish user không được tạo crontab
-rw-r--r--. 1 root root 451 Jun 10  2014 crontab # Crontab hệ thống

cron.d:
total 4
-rw-r--r--. 1 root root 128 Aug  9  2019 0hourly

cron.daily:
total 8
-rwx------. 1 root root 219 Apr  1  2020 logrotate
-rwxr-xr-x. 1 root root 618 Oct 30  2018 man-db.cron

cron.hourly:
total 4
-rwxr-xr-x. 1 root root 392 Aug  9  2019 0anacron

cron.monthly:
total 0

cron.weekly:
total 0

```
Một số lệnh khác
- @reboot : Chạy sau khi reboot.
- @yearly : Chạy hàng năm, ví dụ: 0 0 1 1 *
- @annually : Chạy hàng năm, ví dụ: 0 0 1 1 *
- @monthly : Chạy hàng tháng, ví dụ: 0 0 1 * *
- @weekly : Chạy hàng tuần, ví dụ: 0 0 * * 0
- @daily : Chạy hàng ngày, ví dụ: 0 0 * * *
- @hourly : Chạy mỗi giờ, ví dụ: 0 * * * *

Ví dụ: Tạo một tác vụ chạy vào phút đầu tiên của tháng
```
@monthly /root/Taofile/backup.sh
```
## II. Ứng dụng
- Ex1: Thực thi lệnh lúc 8h30' ngày 10 tháng 7
```
30 08 10 07 * Command
```
- Ex2: Thực thi lệnh lúc 11h00' và 17h00' mỗi ngày
```
00 11,17 * * * Command
```
- Ex3: Thực thi lệnh mỗi giờ từ 7h sáng đến 6h tối:
```
00 07-18 * * * CMD
```
- Ex4: Thực thi lệnh mỗi phút 1 lần:
```
* * * * * CMD
```
- Ex5: Thực thi lệnh mỗi 10 phút 1 lần
```
*/10 * * * * CMD
```
- Ex6: Backup DB mariadvb
Cú pháp:
```
mysqldump -u [username] -p [databaseName] > [filename]-$(date +%F).sql
```
- username – tên người dùng có quyền sao lưu cơ sở dữ liệu
- databasename – tên cơ sở dữ liệu cần sao lưu
- filename – tên của bản sao dữ liệu
- -$(date +%F) mốc thời gian sao lưu dữ liệu
- Để khôi phục sử dụng lệnh:
```
-u [username] -p [databaseName] < backupfile.sql
```
Ví dụ:
```
mysqldump -u admindb -p quanly > backup.sql
```
## Tài liệu tham khảo
1. https://vietnix.vn/crontab/
2. https://www.tutorialspoint.com/unix_commands/crontab.htm