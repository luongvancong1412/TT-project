# Chapter 40: File execution sequence - Trình tự thực thi tệp

.bash_profile , .bash_login , .bashrc và .profile đều làm khá giống nhau: thiết lập và định nghĩahàm, biến và sắp xếp.

Sự khác biệt chính là .bashrc được gọi khi mở cửa sổ không đăng nhập nhưng tương tác và.bash_profile và những cái khác được gọi cho một trình bao đăng nhập. Nhiều người có .bash_profile hoặc cách gọi tương tự.bashrc dù sao.

## 40.1: .profile so với .bash_profile (và .bash_login)

.profile được đọc bởi hầu hết các shell khi khởi động, bao gồm cả bash. Tuy nhiên, .bash_profile được sử dụng cho các cấu hìnhcụ thể cho bash. Đối với mã khởi tạo chung, hãy đặt nó trong tệp .profile . Nếu nó dành riêng cho bash, hãy sử dụng .bash_profile .

.profile không thực sự được thiết kế dành riêng cho bash, thay vào đó , .bash_profile . ( .profile dành cho Bourne vàcác shell tương tự khác, dựa trên bash) Bash sẽ trở lại .profile nếu không tìm thấy .bash_profile .

.bash_login là một dự phòng cho .bash_profile , nếu nó không được tìm thấy. Nói chung tốt nhất nên sử dụng .bash_profile hoặc .profile thay thế