# Redirection/Pipe operators

## Toán tử chuyển hướng đầu vào / đầu ra / lỗi tiêu chuẩn
Toán tử chuyển hướng chuyển hướng đầu ra / đầu vào của một tập lệnh (hoặc tệp) sang một tập lệnh (hoặc tệp) khác làm đầu vào / đầu ra.
- " <", " 0<": Toán tử STDIN (tệp, bàn phím, chuột, ...)

- " >", " 1>": Toán tử STDOUT (tệp, màn hình, máy in, ...)

- " 2>": Toán tử STDERR (tệp, màn hình, máy in, ...)

- " &>": Toán tử STDOUT & STDERR (tệp, màn hình, máy in, ...)

STDIN: đầu vào tiêu chuẩn
STDOUT: đầu ra tiêu chuẩn
STDERR: lỗi tiêu chuẩn

STDOUT và STDERR là hai luồng đầu ra khác nhau.

## Toán tử chuyển hướng STDIN
- < Toán tử chuyển hướng " " STDIN.

Tìm kiếm từ "foo" trong tệp "file1":

- 0 < Toán tử chuyển hướng " " STDIN (giống như " <").

Tìm kiếm từ "foo" trong tệp "file1":
- Việc sử dụng toán tử chuyển hướng STDIN " <" hoặc " 0<" là tùy chọn, vì đó là toán tử mặc định trong trường hợp không có toán tử chuyển hướng rõ ràng.

Tìm kiếm từ "foo" trong tệp "file1":
- Bạn cũng có thể sử dụng toán tử chuyển hướng " <<" cho phép bạn nhập văn bản có thể sử dụng đầu vào chuẩn cho một lệnh.
Cú pháp để sử dụng toán tử này như sau: command << FLAG < ENTER > text < ENTER > ... FLAG< ENTER >
Cờ từ sẽ hoạt động như một chỉ báo rằng bạn đã kết thúc nhập văn bản của mình.

Sắp xếp văn bản đã nhập trong đầu vào chuẩn (giữa << end và end):

## Toán tử chuyển hướng STDOUT
-      > Toán tử chuyển hướng " " STDOUT

Ghi kết quả của dấu comand " ls -al" vào tệp "file1":

- " 1>" Toán tử chuyển hướng STDOUT (giống như " >")

Ghi kết quả của dấu comand " ls -al" trong tệp "file1":

- " >>" Toán tử chuyển hướng STDOUT + append

Nối kết quả của dấu comand " ls -al" trong tệp "file1":

- " 1>>" Toán tử chuyển hướng STDOUT + chắp thêm (giống như >>)

Nối kết quả của dấu comand " ls -al" trong tệp "file1":

## Toán tử chuyển hướng STDERR
- " 2>" Toán tử chuyển hướng STDERR

Viết lỗi ( ls: -: No such file or directory) của dấu " ls -" trong tệp "file1":

- " 2>>" Toán tử chuyển hướng STDERR + chắp thêm

Nối lỗi ( ls: -: No such file or directory) của dấu " ls -" trong tệp "file1":

## Chuyển hướng đầu ra đến một "luồng" khác
- " 1>&2" chuyển hướng STDOUT đến cùng một "luồng" như STDERR

Viết / nối kết quả của lệnh " ls -al" vào cùng một "luồng" như STDERR ("file1"):

- " 2>&1" chuyển hướng STDERR đến cùng một "luồng" như STDOUT

Ghi / nối lỗi ( ls: -: No such file or directory) của lệnh " ls -" vào cùng một "luồng" như STDOUT ("file1"):

Chuyển hướng lỗi đến /dev/null:

## Chuyển hướng cả STDOUT và STDERR đến cùng một "luồng"
" &>" cả toán tử chuyển hướng STDOUT và STDERR.

- Ghi kết quả của comand " ls -al" vào tệp "file1":

- Viết lỗi ( ls: -: No such file or directory) của comand " ls -" trong tệp "file1":

## pipe nhà điều hành
pipe toán tử chuyển hướng đầu ra của một lệnh (ở bên trái của đường ống) như là đầu vào của lệnh tiếp theo (ở bên phải của đường ống).

## tee chỉ huy
tee lệnh chuyển hướng đầu ra của một tập lệnh đến các tệp và STDOUT.