# Chapter 47: Using "trap" to react to signals and system events - Sử dụng "bẫy" để phản ứng lạitín hiệu và sự kiện hệ thống

Tham số|Nghĩa|
|---|---|
-P|Liệt kê các bẫy hiện đã được cài đặt
-l|Liệt kê tên tín hiệu và số tương ứng

## 47.1: Giới thiệu: dọn dẹp các tệp tạm thời

Bạn có thể sử dụng lệnh bẫy để "bẫy" tín hiệu; đây là tương đương với shell của lời gọi signal () hoặc sigaction () trong Cvà hầu hết các ngôn ngữ lập trình khác để bắt tín hiệu.

Một trong những cách sử dụng phổ biến nhất của trap là dọn dẹp các tệp tạm thời trên cả lần thoát dự kiến ​​và không mong muốn.

Thật không may là không có đủ tập lệnh shell để làm điều này :-(
```
#!/bin/sh
# Tạo chức năng dọn dẹp
cleanup() {
rm --force -- "${tmp}"
}

# Bẫy nhóm "EXIT" đặc biệt, nhóm này luôn chạy khi thoát khỏi trình bao.
trap cleanup EXIT

# Tạo tệp tạm thời
tmp="$(mktemp -p /tmp tmpfileXXXXXXX)"

echo "Hello, world!" >> "${tmp}"

# Không cần rm -f "$ tmp". Ưu điểm của việc sử dụng EXIT là nó vẫn hoạt động
# ngay cả khi có lỗi hoặc nếu bạn đã sử dụng lối ra.
```

## 47.2: Bắt SIGINT hoặc Ctl+C - Catching SIGINT or Ctl+C

Bẫy được đặt lại cho các vỏ con, vì vậy chế độ ngủ sẽ vẫn hoạt động trên tín hiệu SIGINT được gửi bởi ^ C (thường bằng cách thoát), nhưngquy trình cha (tức là tập lệnh shell) sẽ không.

```
#!/bin/sh
# Chạy lệnh trên tín hiệu 2 (SIGINT, là thứ mà ^ C gửi)
sigint() {
    echo "Killed subshell!"
}
trap sigint INT

# Hoặc sử dụng lệnh no-op để không có đầu ra
#trap: INT

# Điều này sẽ bị giết vào ngày đầu tiên ^C
echo "Sleeping..."
sleep 500

echo "Sleeping..."
sleep 500
```

Và một biến thể vẫn cho phép bạn thoát khỏi chương trình chính bằng cách nhấn ^C hai lần trong một giây:

```
last=0
allow_quit() {
    [ $(date +%s) -lt $(( $last + 1 )) ] && exit
    echo "Press ^C twice in a row to quit"
    last=$(date +%s)
}
trap allow_quit INT
```

## 47.3: Tích lũy danh sách các công việc bẫy để chạy khi thoát - Accumulate a list of trap work to run at exit

Bạn đã bao giờ quên thêm một cái bẫy để dọn dẹp tệp tạm thời hoặc làm công việc khác khi thoát chưa?

Bạn đã bao giờ đặt một cái bẫy mà hủy một cái bẫy khác chưa?

Mã này giúp bạn dễ dàng thêm những việc cần làm khi thoát từng mục một, thay vì có một cái bẫy lớncâu lệnh ở đâu đó trong mã của bạn, có thể dễ bị quên.
```
# on_exit và add_on_exit
# Cách sử dụng:
# add_on_exit rm -f / tmp / foo
# add_on_exit echo "Tôi đang thoát"
# tempfile = $ (mktemp)
# add_on_exit rm -f "$ tempfile"
# Dựa trên http://www.linuxjournal.com/content/use-bash-trap-statement-cleanup-tempional-files
function on_exit()
{
    for i in "${on_exit_items[@]}"
    do
        eval $i
    done
}
function add_on_exit()
{
    local n=${#on_exit_items[*]}
    on_exit_items[$n]="$*"
    if [[ $n -eq 0 ]]; then
        trap on_exit EXIT
    fi
}
```

## 47.4: Xử lý giết trẻ em khi xuất cảnh - Killing Child Processes on Exit

Biểu thức bẫy không nhất thiết phải là các hàm hoặc chương trình riêng lẻ, chúng cũng có thể là các biểu thức phức tạp hơn.

Bằng cách kết hợp các job -p và kill , chúng ta có thể giết tất cả các process con được tạo ra của shell khi thoát:

```
trap 'jobs -p | xargs kill' EXIT
```

## 47.5: phản ứng khi thay đổi kích thước cửa sổ thiết bị đầu cuối - react on change of terminals window size

Có một tín hiệu CHIẾN THẮNG (WINdowCHange), tín hiệu này được kích hoạt khi một người thay đổi kích thước cửa sổ đầu cuối.

```
declare -x rows cols
update_size(){
    rows=$(tput lines) # get actual lines of term
    cols=$(tput cols) # get actual columns of term
    echo DEBUG terminal window has no $rows lines and is $cols characters wide
}

trap update_size WINCH
```