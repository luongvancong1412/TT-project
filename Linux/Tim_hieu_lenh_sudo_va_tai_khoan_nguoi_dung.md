Tìm hiểu lệnh sudo trong linux
1. Sudo là gì
Lệnh sudo cho phép một user thực thi một lệnh bằng quyền của root. 
1.1Lý do phải sử dụng sudo
Tăng cường tính bảo mật cho hệ thống.
Quản lý quyền hạn của từng user hoặc group trong việc thực thi lệnh.
Cho phép nhà quản trị kiểm soát được các thao tác của người dùng có can thiệp đến hệ thống. Ngoài ra khi thực thi lệnh từ xa thông qua telnet/SSH thì sudo thực sự thể hiện ưu thế
1.2 Chức năng
Sudo được dùng khi ta muốn thực thi một lệnh trên Linux với quyền của một user khác. Nếu được cho phép, ta sẽ thực thi một lệnh như là người quản trị hay một user nào khác. 
Quyền của user trong file /etc/sudoers.
Những ghi nhận (log) của hệ thống khi sudo được sử dụng theo mặc định:
/var/log/secure (Red Hat/Fedora / CentOS Linux)
/var/log/auth.log (Ubuntu / Debian Linux).
1.3 Cú pháp cơ bản của sudo

sudo <lệnh cần thực hiện>


Mặc định sudo sẽ xem như ta đang mượn quyền root để thực thi.
Nếu ta muốn “mượn” một người dùng nào khác thì khai báo định danh rõ ràng của người đó:
sudo -u <username> <lệnh cần thực hiện>


File cấu hình sudo

/etc/sudoes
/etc/sudoes.d/


2. File /etc/sudoers
Nội dung trong file này thường được đặc tả bằng cú pháp sau:

USER HOSTNAME=(TARGET-USERS) COMMAND


Trong đó:

USER: Tên của người sử dụng
HOSTNAME: Tên máy mà luật được áp dụng lên. Lúc này sudo sẽ xem máy đang chạy được dùng các luật nào. Nói cách khác, bạn có thể thiết kế các luật cho từng máy trong hệ thống.
TARGET-USERS: Tên người dùng đích cho “mượn” quyền thực thi.
COMMAND: Tên “lệnh” (thực ra là các chương trình thực thi) mà người dùng được quyền thực thi với bất kỳ tham số nào mà họ muốn. Tuy nhiên bạn cũng có thể đặc tả các tham số của lệnh (bao gồm các dấu thay thế wildcards). Ngược lại, có thể dùng kí hiệu “” để ám chỉ là lệnh chỉ được thực thi mà không có tham số nào cả.
Nếu là cấp quyền cho group, ta thay tham số USER bằng %GROUP
2.1 Thiết lập cho sudo
Tiến hành thiết lập cho sudo bằng cách soạn thảo file này. Để mở file sudo lên và soạn thảo, ta dùng lệnh sau:

# visudo


” root ALL=(ALL) ALL”có nghĩa là người dùng root, trên tất cả các máy, có thể mượn quyền tất cả các người dùng, để thực thi tất cả các lệnh.
“%admin ALL=(ALL) ALL” có nghĩa là nhóm người dùng admin, trên tất cả các máy, có thể mượn quyền tất cả các người dùng, để thực thi tất cả các lệnh.
3. Thêm quyền/giới hạn quyền cho User
Chúng ta có thể thêm quyền cho người dùng bằng cách chỉnh sửa file sudoers
#vi /etc/sudoers


tìm và gõ đoạn code sau

root ALL=(ALL) ALL
user3 ALL=(root) /bin/ls


như vậy, User3 đã có thể đọc các thư mục ở Root.

Muốn User sadly không phải nhập mật khẩu mỗi lần ls /root, ta thêm như sau :


user3 ALL=(root) NOPASSWD: /bin/ls


