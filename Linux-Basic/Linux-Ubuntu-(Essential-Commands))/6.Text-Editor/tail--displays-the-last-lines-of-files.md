# tail -- displays the last lines of files

## 1.Notes
usage:
```
tail file ...
```
In 10 dòng cuối cùng của mỗi tệp ở đầu ra tiêu chuẩn.
Với nhiều tệp, hãy đặt trước mỗi tệp một tiêu đề cho tên tệp.
Khi không có tệp hoặc khi có tệp - , hãy đọc đầu vào chuẩn.

## 2.Examples
```
tail -f file1
```

```
tail -n 50 file1
```

## 3.Command Help (man tail)

Các tùy chọn sau có thể được sử dụng:

-c , --bytes = [ + ] NUM xuất ra NUM byte cuối cùng; hoặc sử dụng -c  + NUM để xuất bắt đầu bằng NUM byte của mỗi tệp

-f , --follow [ = {name | descriptor}] xuất dữ liệu nối thêm khi tệp phát triển; một đối số tùy chọn vắng mặt có nghĩa là 'bộ mô tả'

-Giống                                 như --follow = name --retry

-n , --lines = [ + ] NUM xuất ra NUM dòng cuối cùng, thay vì 10 dòng cuối cùng ; hoặc sử dụng -n  + NUM để xuất ra bắt đầu bằng dòng NUM

max-nguyên-số liệu thống kê = N     với --follow = tên, mở lại một FILE mà vẫn không thay đổi kích thước sau khi N (mặc định 5 ) lặp đi lặp lại để xem nếu nó đã được bỏ liên kết hay đổi tên
(đây là trường hợp thông thường của các tệp nhật ký được xoay);với inotify, tùy chọn này hiếm khi hữu ích

--pid = PID     với -f , kết thúc sau ID quy trình, PID chết

-q , --quiet , --silent              không bao giờ xuất các tiêu đề cung cấp tên tệp

--retry                        tiếp tục cố gắng mở một tệp nếu nó không thể truy cập được

-s , --sleep-interval=N     với -f , giấc ngủ  cho khoảng N giây (mặc định 1 .0) giữa lặp;
với inotify và --pid = P, kiểm tra quá trình P ít nhất một lần sau N giây

-v , --verbose                 luôn xuất ra các tiêu đề cho tên tệp

-z , --zero-terminated            dấu phân cách dòng kết thúc bằngzero là NUL, không phải dòng mới

--help                      hiển thị trợ giúp này và thoát
--version   thông tin phiên bản đầu ra phiên bản và thoát

NUM có thể có hậu tố cấp số nhân:
b 512
kB 1000
K 1024
MB 1000*1000
M 1024*1024
GB 1000*1000*1000
G 1024*1024*1024
and so on for T, P, E, Z, Y.

Với - follow ( -f ), tail mặc định theo sau bộ mô tả tệp, có nghĩa là ngay cả khi một tệp riêng được đổi tên, tail sẽ tiếp tục theo dõi phần cuối của nó.
Hành vi mặc định này không được mong muốn khi bạn thực sự muốn theo dõi tên thực của tệp, không phải bộ mô tả tệp (ví dụ: xoay bản ghi).
Sử dụng --follow = name trong trường hợp đó.
Điều đó gây ra đuôi để theo dõi tệp được đặt tên theo cách phù hợp với việc đổi tên, xóa và tạo.