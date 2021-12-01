#

## 1.Notes

Lệnh crontab được sử dụng để quản lý danh sách các lệnh phải chạy theo một lịch trình cụ thể.
Mỗi người dùng có thể có crontab của riêng mình.

Nếu tệp " /usr/lib/cron/cron.allow" tồn tại, thì tên người dùng phải được liệt kê trong đó, nếu không người dùng sẽ không được phép sử dụng lệnh crontab.

Nếu tệp " /usr/lib/cron/cron.deny" tồn tại, thì tên người dùng không được liệt kê trong đó, nếu không người dùng sẽ không được phép sử dụng lệnh crontab.

## Examples
- Quản lý crontab của người dùng hiện tại

Lưu và thoát. Bạn sẽ thấy các thông báo sau trong đầu ra tiêu chuẩn:

Bạn có thể kiểm tra xem crontab đã được cài đặt chưa:


Bạn có thể liệt kê crontab của tất cả người dùng:

Bạn có thể kiểm tra crontab excution:

Quản lý crontab của người dùng khác.

#lưu và thoát. Bạn sẽ thấy các thông báo sau trong đầu ra tiêu chuẩn:

Bạn có thể kiểm tra xem crontab đã được cài đặt chưa:

## Command Help (man crontab)
- Các tùy chọn sau có thể được sử dụng:
-u
| Chỉ định tên của người dùng có crontab sẽ được sử dụng.
| Nếu tùy chọn này không được đưa ra, thì crontab của người dùng hiện tại sẽ được sử dụng.
| Tùy chọn này rất quan trọng khi sử dụng "su" để chạy lệnh crontab.
​

-l
| Hiển thị crontab hiện tại trên đầu ra tiêu chuẩn.

-r
| Xóa crontab hiện tại.
​
-e
| Chỉnh sửa crontab bằng trình chỉnh sửa được chỉ định bởi các biến môi trường VISUAL hoặc EDITOR.
| Sau khi thoát khỏi trình chỉnh sửa, crontab đã sửa đổi sẽ được áp dụng tự động.

- Thêm các mục crontab.
Mỗi mục nhập trong crontab có thể có cú pháp sau "min giờ ngày tháng day_of_week" trong đó:

tối thiểu: [0 -  59 ]

giờ: [0 -  23 ]

ngày: [1 -  31 ]

tháng: [1 -  12 ]

ngày trong tuần: [0 -  7 ] (kiểm tra hệ thống của bạn nếu  0 hoặc 7 tham chiếu Chủ nhật)

- Bạn cũng có thể sử dụng các mẫu sau để khớp với giá trị của lịch biểu:

*: khớp với bất kỳ giá trị nào trong số các giá trị được phép
​
-: chỉ định một phạm vi giá trị: 9 -15 (có nghĩa là bất kỳ giá trị nào từ 9 đến 15 )
​
,: chỉ định danh sách giá trị hoặc phạm vi giá trị: 7 , 9-15,35 (nghĩa là 7 , bất kỳ giá trị nào từ 9 đến 15 và 35 )

/: chỉ định các bước trên một phạm vi giá trị: * / 3 (hàng giờ, 3 giờ một lần), 8/2 (hàng giờ, cứ sau 2 giờ bắt đầu từ 8 giờ)

name_of_the_day: sử dụng ba chữ cái đầu tiên của ngày (phạm vi hoặc danh sách tên không được phép)

name_of_the_month: sử dụng ba chữ cái đầu tiên của tháng (phạm vi hoặc danh sách tên không được phép)