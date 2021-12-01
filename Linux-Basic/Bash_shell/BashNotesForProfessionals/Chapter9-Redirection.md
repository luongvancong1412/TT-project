# Chapter 9: Redirection


## 9.1: Redirecting standard output - Chuyển hướng đầu ra tiêu chuẩn

">"chuyển hướng đầu ra tiêu chuẩn (hay còn gọi là STDOUT ) của lệnh hiện tại thành một tệp hoặc bộ mô tả khác.

Các ví dụ này ghi kết quả đầu ra của lệnh ls vào tệp tin file.txt
```
ls > file.txt
> file.txt ls
```
Tệp đích được tạo nếu nó không tồn tại, nếu không tệp này sẽ bị cắt bớt.
Bộ mô tả chuyển hướng mặc định là đầu ra tiêu chuẩn hoặc 1 khi không có giá trị nào được chỉ định. Lệnh này tương đươngđối với các ví dụ trước với đầu ra tiêu chuẩn được chỉ ra rõ ràng:

```ls 1 > file.txt```

Lưu ý: chuyển hướng được khởi tạo bởi trình bao được thực thi chứ không phải bởi lệnh được thực thi, do đó nó được thực hiệntrước khi thực hiện lệnh.

## 9.2: Append vs Truncate - Nối vs Cắt bớt

**Cắt bỏ >**
    1.Tạo tệp được chỉ định nếu nó không tồn tại.
    2.Cắt bớt (xóa nội dung của tệp)
    3. Ghi vào tệp
```
$ echo "first line" > /tmp/lines
$ echo "second line" > /tmp/lines
$ cat /tmp/lines
second line
```
**Nối >>**
1.Tạo tệp được chỉ định nếu nó không tồn tại.
2.Nối tệp (ghi ở cuối tệp).

```
# Overwrite existing file
$ echo "first line" > /tmp/lines
# Append a second line
$ echo "second line" >> /tmp/lines
$ cat /tmp/lines
first line
second line
```

## 9.3: Redirecting both STDOUT and STDERR - Chuyển hướng cả STDOUT và STDERR

Các bộ mô tả tệp như 0 và 1 là các con trỏ. Chúng tôi thay đổi trình mô tả tệp trỏ tới bằng chuyển hướng. > / dev / nullcó nghĩa là 1 điểm đến / dev / null .

Đầu tiên chúng ta trỏ 1 ( STDOUT ) vào / dev / null sau đó trỏ 2 ( STDERR ) vào bất cứ 1 điểm nào.

```
# STDERR is redirect to STDOUT: redirected to /dev/null,
# effectually redirecting both STDERR and STDOUT to /dev/null
echo 'hello' > /dev/null 2>&1
Version ≥ 4.0
```

Điều này có thể được rút ngắn hơn nữa thành sau:
```
echo 'hello' &> /dev/null
```

Tuy nhiên, biểu mẫu này có thể không được mong muốn trong quá trình sản xuất nếu mối quan tâm về khả năng tương thích của shell vì nó xung đột với POSIX,giới thiệu sự mơ hồ về phân tích cú pháp và các shell không có tính năng này sẽ hiểu sai về nó:
```
# Actual code
echo 'hello' &> /dev/null
echo 'hello' &> /dev/null 'goodbye'
# Desired behavior
echo 'hello' > /dev/null 2>&1
echo 'hello' 'goodbye' > /dev/null 2>&1
# Actual behavior
echo 'hello' &
echo 'hello' & goodbye > /dev/null
```

LƯU Ý: &> được biết là hoạt động như mong muốn trong cả Bash và Zsh.

## 9.4: Using named pipes - Sử dụng các đường ống được đặt tên

Đôi khi bạn có thể muốn xuất một cái gì đó bằng một chương trình và nhập nó vào một chương trình khác, nhưng không thể sử dụngống tiêu chuẩn.

```
ls -l | grep ".log"
```

Bạn có thể chỉ cần ghi vào một tệp tạm thời:
> touch tempFile.txt
ls -l > tempFile.txt
grep ".log" < tempFile.txt


Điều này hoạt động tốt cho hầu hết các ứng dụng, tuy nhiên, sẽ không ai biết tempFile làm gì và ai đó có thể xóanó nếu nó chứa đầu ra của ls -l trong thư mục đó. Đây là nơi mà một đường ống được đặt tên phát huy tác dụng:

> mkfifo myPipe
ls -l > myPipe
grep ".log" < myPipe

myPipemyPipe về mặt kỹ thuật là một tệp (mọi thứ đều có trong Linux), vì vậy chúng ta hãy làm ls -l trong một thư mục trống mà chúng ta vừa tạo một đường ốngtrong:

> mkdir pipeFolder
cd pipeFolder
mkfifo myPipe
ls -l

Đầu ra là:

```prw-r--r-- 1 root root 0 Jul 25 11:20 myPipe```


Lưu ý đến ký tự đầu tiên trong quyền, nó được liệt kê dưới dạng một đường ống, không phải tệp.

Bây giờ chúng ta hãy làm một cái gì đó thú vị.

Mở một thiết bị đầu cuối và ghi chú lại thư mục (hoặc tạo một thư mục để việc dọn dẹp được dễ dàng) và tạo một đường dẫn.

``mkfifo myPipe``

Bây giờ chúng ta hãy đặt một cái gì đó vào đường ống.

```echo "Hello from the other side" > myPipe```

Bạn sẽ nhận thấy bên này bị treo, bên kia của đường ống vẫn đóng. Hãy mở phía bên kia của đường ống và để điều đóthông qua.

Mở một thiết bị đầu cuối khác và đi tới thư mục chứa đường dẫn (hoặc nếu bạn biết, hãy thêm nó vào đường dẫn):

```cat < myPipe```

Bạn sẽ nhận thấy rằng sau khi lời chào từ phía bên kia được xuất ra, chương trình trong thiết bị đầu cuối đầu tiên sẽ kết thúc, cũng như vậyđó trong thiết bị đầu cuối thứ hai.

Bây giờ hãy chạy ngược lại các lệnh. Bắt đầu với cat < myPipe và sau đó lặp lại nội dung nào đó vào đó. Nó vẫn hoạt động, bởi vìmột chương trình sẽ đợi cho đến khi một thứ gì đó được đưa vào đường ống trước khi kết thúc, bởi vì nó biết rằng nó phải nhận đượcthứ gì đó.

Các đường ống được đặt tên có thể hữu ích cho việc di chuyển thông tin giữa các thiết bị đầu cuối hoặc giữa các chương trình.

Đường ống nhỏ. Sau khi đầy, trình viết sẽ chặn cho đến khi một số người đọc đọc nội dung, vì vậy bạn cần chạyngười đọc và người viết trong các thiết bị đầu cuối khác nhau hoặc chạy cái này hay cái kia trong nền:

```
ls -l /tmp > myPipe &
cat < myPipe
```

**Các ví dụ khác sử dụng các đường ống được đặt tên(name pipes)**

Ex1 - tất cả các lệnh trên cùng một thiết bị đầu cuối / cùng một trình shell
```
$ { ls -l && cat file3; } >mypipe &
$ cat <mypipe
# Output: Prints ls -l data and then prints file3 contents on screen
```
Đầu ra: In dữ liệu ls -l và sau đó in nội dung file3 trên màn hình

Ex2 - tất cả các lệnh trên cùng một thiết bị đầu cuối / cùng một trình shell

```
$ ls -l >mypipe &
$ cat file3 >mypipe &
$ cat <mypipe
#Output: Thao tác này sẽ in ra nội dung của mypipe.
```

Lưu ý rằng nội dung đầu tiên của tệp 3 được hiển thị và sau đó dữ liệu ls -l được hiển thị (cấu hình LIFO).

Ex3 - tất cả các lệnh trên cùng một thiết bị đầu cuối / cùng một trình shell
```
$ { pipedata=$(<mypipe) && echo "$pipedata"; } &
$ ls >mypipe
# Output: In đầu ra của ls trực tiếp trên màn hình
```