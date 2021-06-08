Hướng dẫn cài đặt Apache trên Centos 7 64bit
# 1. Cài đặt Apache
Apache là nền tảng Web server mã nguồn mở. 

- là một phần mềm chạy trên server.
- Công việc: thiết lập kết nối giữa server và trình duyệt người dùng (Firefox, Google Chrome, Safari,...) rồi chuyển file tới và lui giữa chúng (cấu trúc 2 chiều dạng client-server).
- là một phần mềm đa nền tảng, nó hoạt động tốt với cả server Unix và Windows.

Hoạt động:

- Khi một khách truy cập tải một trang web trên website của bạn,trình duyệt người dùng sẽ gửi yêu cầu tải trang web đó lên server và Apache sẽ trả kết quả với tất cả đầy đủ các file cấu thành nên trang (hình ảnh, chữ,...). 
- Server và client giao tiếp với nhau qua giao thức HTTP và Apache chịu trách nhiệm cho việc đảm bảo tiến trình này diễn ra mượt mà và bảo mật giữa 2 máy.

Lệnh cài đặt Apache:

|# yum install httpd –y|
| - |
![](Aspose.Words.f84b6971-5109-4601-962b-bbb74df8e71c.001.png)

Khởi chạy Apache:

|# systemctl start httpd|
| - |
![](Aspose.Words.f84b6971-5109-4601-962b-bbb74df8e71c.002.png)

Tự động chạy khi khởi động:

|# systemctl enable httpd|
| - |
![](Aspose.Words.f84b6971-5109-4601-962b-bbb74df8e71c.003.png)

Kiểm tra trạng thái hoạt động của Apache:

|# systemctl status httpd|
| - |
![](Aspose.Words.f84b6971-5109-4601-962b-bbb74df8e71c.004.png)

Mở port trên firewall:

|<p># firewall-cmd --permanent --zone=public --add-service=http</p><p># firewall-cmd --permanent --zone=public --add-service=https</p><p># firewall-cmd --reload</p>|
| - |
Dừng Apache:

|# systemctl stop httpd|
| - |
Khởi động lại Apache:

|# systemctl restart httpd|
| - |
# 2. Đặt trang html
- Vào thư mục chứa code

![](Aspose.Words.f84b6971-5109-4601-962b-bbb74df8e71c.005.png)

- Tạo file index.html

![](Aspose.Words.f84b6971-5109-4601-962b-bbb74df8e71c.006.png)

- Tạo 1 trang html đơn giản

![](Aspose.Words.f84b6971-5109-4601-962b-bbb74df8e71c.007.png)

- Truy cập bằng trình duyệt để kiểm tra:

![](Aspose.Words.f84b6971-5109-4601-962b-bbb74df8e71c.008.png)
# 3. Các file cấu hình
- Tất cả các file cấu hình của Apache đều nằm trong thư mục **/etc/httpd**

![](Aspose.Words.f84b6971-5109-4601-962b-bbb74df8e71c.009.png)

- File cấu hình chính của Apache là **/etc/httpd/conf/httpd.conf**

![](Aspose.Words.f84b6971-5109-4601-962b-bbb74df8e71c.010.png)

- Tất cả các tệp cấu hình đều phải kết thúc bằng .conf và nằm trong thư mục **/etc/httpd/conf.d**.

![](Aspose.Words.f84b6971-5109-4601-962b-bbb74df8e71c.011.png)

- Các tệp cấu hình chịu trách nhiệm tải các modules Apache được đặt trong thư mục **/etc/httpd/conf.modules.d**.
- ![](Aspose.Words.f84b6971-5109-4601-962b-bbb74df8e71c.012.png)
- Để quản lý tốt hơn, nên tạo một tệp cấu hình riêng (vhost) cho mỗi tên miền.
- Các tệp vhost Apache phải kết thúc bằng .conf và được lưu trữ trong thư mục /etc/httpd/conf.d. Ví dụ: nếu tên miền của bạn là mydomain.com thì tệp cấu hình sẽ được đặt tên /etc/httpd/conf.d/mydomain.com.conf
- Các file log của Apache ( access \_ log và error \_ log ) nằm trong thư mục **/var/log/httpd/**. Bạn nên có file log riêng cho mỗi vhost.

![](Aspose.Words.f84b6971-5109-4601-962b-bbb74df8e71c.013.png)
# 3. File log
Đường dẫn chứa file log:

- /var/log/httpd/
- /etc/httpd/logs
## 3.1 Access\_log log đăng nhập
![](Aspose.Words.f84b6971-5109-4601-962b-bbb74df8e71c.014.png)

Khi có 1 host truy cập vào website

![](Aspose.Words.f84b6971-5109-4601-962b-bbb74df8e71c.015.png)
## 3.2 Error\_log: log lỗi dịch vụ
![](Aspose.Words.f84b6971-5109-4601-962b-bbb74df8e71c.016.png)
