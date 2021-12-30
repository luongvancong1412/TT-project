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
```
su user
crontab -e
```
- Cấu hình crontab cho System-wide:Cấu hình trong file
```
vi /etc/crontab
```

```
[sinhvien@conglv etc]$ ls cron*
cron.deny  crontab

cron.d:
0hourly

cron.daily:
logrotate  man-db.cron

cron.hourly:
0anacron

cron.monthly:

cron.weekly:
```
- @reboot : Chạy sau khi reboot.
- @yearly : Chạy hàng năm, ví dụ: 0 0 1 1 *
- @annually : Chạy hàng năm, ví dụ: 0 0 1 1 *
- @monthly : Chạy hàng tháng, ví dụ: 0 0 1 * *
- @weekly : Chạy hàng tuần, ví dụ: 0 0 * * 0
- @daily : Chạy hàng ngày, ví dụ: 0 0 * * *
- @hourly : Chạy mỗi giờ, ví dụ: 0 * * * *
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

## Tài liệu tham khảo
1. https://vietnix.vn/crontab/
2. https://www.tutorialspoint.com/unix_commands/crontab.htm