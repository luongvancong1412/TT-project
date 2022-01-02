# Vim

## 1.Notes
Vim (Vi IMproved) là một trình soạn thảo văn bản có thể được sử dụng để chỉnh sửa tất cả các loại văn bản thuần túy.

Trước khi bạn bắt đầu chỉnh sửa văn bản, màn hình ở trạng thái chế độ bảng điều khiển. Khi bạn bắt đầu chèn văn bản, màn hình đang ở trạng thái chế độ chèn (bạn sẽ thấy -- INSERT --ở cuối màn hình). Khi bạn hoàn tất việc chỉnh sửa văn bản, bạn có thể nhấn Escphím để trở về trạng thái chế độ bảng điều khiển.
## lệnh vi: INSERT

tôi
| chèn văn bản, trước con trỏ, cho đến khi người dùng nhấn <esc>

​
Một
| chèn văn bản, sau con trỏ, cho đến khi người dùng nhấn <esc>
​
tôi
| chèn văn bản, ở đầu dòng hiện tại, cho đến khi người dùng nhấn <esc>
​
MỘT
| chèn văn bản vào cuối dòng hiện tại cho đến khi người dùng nhấn <esc>
​

o
| chèn một dòng mới bên dưới dòng hiện tại, chèn văn bản, cho đến khi người dùng nhấn <esc>
​
O
| chèn một dòng mới phía trên dòng hiện tại, chèn văn bản, cho đến khi người dùng nhấn <esc>

## lệnh vi: REPLACE

NS
| thay thế ký tự dưới con trỏ bằng một ký tự khác
​

NS
| thay thế nhiều ký tự, bắt đầu bằng ký tự dưới con trỏ, cho đến khi người dùng nhấn <esc>
​

cw
| thay thế từ, bắt đầu bằng ký tự dưới con trỏ, cho đến khi người dùng nhấn <esc>
​
c {n} w
| thay thế {n} từ, bắt đầu bằng ký tự dưới con trỏ, cho đến khi người dùng nhấn <esc> (c3w: thay thế 3 từ)
​

NS
| thay thế phần còn lại của dòng, bắt đầu bằng ký tự dưới con trỏ, cho đến khi người dùng nhấn <esc>
​

cc
| thay thế dòng hiện tại, cho đến khi người dùng nhấn <esc>
​
{n} cc

c {n} c
| thay thế {n} dòng, bắt đầu bằng dòng hiện tại, cho đến khi người dùng nhấn <esc>

## lệnh vi: DELETE

NS

| xóa ký tự dưới con trỏ
​

{n} x
| xóa {n} ký tự, bắt đầu bằng ký tự dưới con trỏ (3x: xóa 3 ký tự)

​

dw

| xóa từ, bắt đầu bằng ký tự dưới con trỏ

​

d {n} w

| xóa {n} từ, bắt đầu bằng ký tự dưới con trỏ (d3w: xóa 3 từ)

​

NS

| xóa phần còn lại của dòng, bắt đầu bằng ký tự dưới con trỏ

​

dd

| xóa dòng hiện tại

​

{n} đ

d {n} d

| xóa {n} dòng, bắt đầu bằng dòng hiện tại (3dd: xóa 3 dòng)

## lệnh vi: COPY / PASTE

yy

| sao chép dòng hiện tại vào khay nhớ tạm
​

{n} yy

y {n} y

| sao chép {n} dòng, bao gồm cả dòng hiện tại, vào khay nhớ tạm (3yy: sao chép 3 dòng)
​

P
| chèn văn bản từ khay nhớ tạm vào sau dòng hiện tại

## lệnh vi: UNDO

u
| hoàn tác sửa đổi cuối cùng

## lệnh vi: TÌM KIẾM

/{mẫu}
| Tìm kiếm về phía trước trong các tập tin cho sự xuất hiện của chuỗi (/ foo: tìm kiếm cho chuỗi "foo" )
​
?{mẫu}
| Tìm kiếm ngược trong tệp để biết sự xuất hiện của chuỗi

​

n
| Tìm kiếm về phía trước trong tệp để biết lần xuất hiện tiếp theo của chuỗi

​

n
| Tìm kiếm ngược trong tệp để tìm lần xuất hiện trước đó của chuỗi

## lệnh vi: CURSOR

N
<trở lại>
<mũi tên xuống>
| di chuyển con trỏ xuống một dòng
​
k
<mũi tên lên>
| di chuyển con trỏ lên một dòng
​

NS
<xóa>
<mũi tên trái>
| di chuyển con trỏ sang trái một ký tự

​

l
<dấu cách>
<mũi tên phải>
| di chuyển con trỏ sang phải một ký tự
​

0

| di chuyển con trỏ đến đầu dòng hiện tại

​
$
| di chuyển con trỏ đến cuối dòng hiện tại


w
| di chuyển con trỏ tới đầu từ tiếp theo

​

NS
| di chuyển con trỏ về đầu từ trước đó

​
:0 <trở lại>
1G
| di chuyển con trỏ đến dòng đầu tiên
​
:n <trở về>
{n} G
| di chuyển con trỏ đến dòng {n}
​
:$ <trở lại>
NS
| di chuyển con trỏ đến dòng đầu tiên

## lệnh vi: SCREEN

<kiểm soát> f
| di chuyển xuống một màn hình

​
<kiểm soát> b
| di chuyển lên một màn hình

​

<kiểm soát> d
| di chuyển xuống một nửa màn hình

​

<kiểm soát> u
| di chuyển lên một nửa màn hình

​

<kiểm soát> l
| vẽ lại màn hình

​

<kiểm soát> r
| vẽ lại màn hình, xóa các dòng đã xóa

## 10.lệnh vi: LINES

:.= < return>
| hiển thị số dòng hiện tại ở cuối màn hình

​
:= < return>
| hiển thị tổng số dòng ở cuối màn hình

< control> g
| hiển thị thông tin chi tiết (số dòng hiện tại, tổng số dòng, ...) ở cuối màn hình
| ví dụ: "file1" [Đã sửa đổi] dòng 4 trên 11  --36 % - cột 5

## 11.lệnh vi: READ / SAVE

:r < return>
| đọc tệp hiện tại và chèn nội dung của nó sau dòng hiện tại
​

:r {filename} < return>
| đọc tệp "tên tệp" và chèn nội dung của tệp sau dòng hiện tại
​
:w < return>
| lưu tệp hiện tại
​
:w {filename} < return>
| lưu nội dung vào tệp "tên tệp"
| Nó sẽ khiếu nại nếu tệp "tên tệp" đã tồn tại: "Tệp tồn tại (thêm! Để ghi đè)"

:w! {filename} < return>
| buộc lưu nội dung vào tệp "tên tệp" , ngay cả khi tệp đã tồn tại
​
:{n},{m}w {filename} < return>
| lưu vào tệp "tên tệp" nội dung của các dòng được đánh số từ {n} đến {m}
| Nó sẽ khiếu nại nếu tệp "tên tệp" đã tồn tại: "Tệp tồn tại (thêm! Để ghi đè)"

:{n},{m}w! < return>
| lưu vào tệp hiện tại nội dung của các dòng được đánh số từ {n} đến {m}

:{n},{m}w! {filename} < return>
| lưu vào tệp "tên tệp" nội dung của các dòng được đánh số từ {n} đến {m}

## 12.lệnh vi: EXIT

:x < return>
:wq < return>
| thoát vim  + lưu tệp đã sửa đổi
​

:q < return>
| exit vim (sẽ khiếu nại nếu tệp đã bị thay đổi: "Không ghi kể từ lần thay đổi cuối cùng (thêm! để ghi đè)" )

:q! < return>
| thoát vim  + loại bỏ tất cả các sửa đổi