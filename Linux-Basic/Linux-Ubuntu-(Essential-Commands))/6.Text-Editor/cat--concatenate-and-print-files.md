# cat -- concatenate and print files

## 1.Notes
```
cat file ...
```
Các catlệnh có một danh sách tên tập tin cho các đối số của nó.
Nó xuất nội dung của những tệp đó trực tiếp ra đầu ra tiêu chuẩn, theo mặc định, được dẫn đến màn hình.
## 2.Examples
- Viết nội dung của một tệp:
Bạn có thể sử dụng tùy chọn -n để in số dòng:

- Viết nội dung của nhiều tệp:
- Viết nội dung của nhiều tệp lần lượt ( enter EOF character ('^D') for each file):
## 3.Command Help (man cat)
Các tùy chọn sau có thể được sử dụng:

-n
| Đánh số các dòng đầu ra, bắt đầu từ 1 .

-b
| Đánh số các dòng đầu ra không trống, bắt đầu từ 1 .

​
-v
| Hiển thị các ký tự không in để chúng có thể nhìn thấy được.
| Các ký tự điều khiển in ra dưới dạng "^ X"  cho control-X; ký tự xóa (bát phân 0177 ) in ra là "^?" .
| Ký tự không phải là ASCII (với bit cao bộ ) được in như "M" (meta) tiếp theo là nhân vật cho các thấp 7 bit.