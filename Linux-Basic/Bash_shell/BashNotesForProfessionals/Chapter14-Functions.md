# Chapter 14: Functions - Hàm

## 14.1:14.1: Functions with arguments - Các hàm có đối số

Trong helloJohn.sh :

```
#!/bin/bash
greet() {
local name="$1"
echo "Hello, $name"
}
greet "John Doe"
# đang chạy tập lệnh phía trên
$ bash helloJohn.sh
Hello, John Doe
```

1. Nếu bạn không sửa đổi các tham số dưới mọi hình thức, không có cần phải sao chép nó vào một biến `local` - chỉ đơn giản là `echo "Hello, $1"`. 
2. Bạn có thể sử dụng `$1`, `$2`, `$3`, v.v. để truy cập các đối số bên trong hàm.
>Lưu ý: đối với các đối số nhiều hơn `9` `$10` sẽ không hoạt động (bash sẽ đọc nó là `$10`), bạn cần thực hiện `${10}` , `${11}` , v.v.

3. `$@` tham chiếu đến tất cả các đối số của một hàm:
```
#!/bin/bash
foo() {
echo "$@"
}
foo 1 2 3 # output => 1 2 3
```

>Lưu ý: Trên thực tế, bạn nên luôn sử dụng dấu ngoặc kép xung quanh "$@" , như ở đây.

Việc bỏ qua các dấu ngoặc kép sẽ khiến trình bao mở rộng các ký tự đại diện (ngay cả khi người dùng đã trích dẫn cụ thể chúng trongđể tránh điều đó) và thường đưa ra các hành vi không được hoan nghênh và thậm chí có thể có các vấn đề về bảo mật.

```
foo "string with spaces;" '$HOME' "*"
# output => string with spaces; $HOME *
```

4. đối với các đối số mặc định, hãy sử dụng `${1: -default_val}` . Ví dụ:
```
#!/bin/bash
foo() {
local val=${1:-25}
echo "$val"
}
foo # output => 25
foo 30 # output => 30
```

5. để yêu cầu một đối số, hãy sử dụng `${var:? error message}`

```
foo() {
local val=${1:?Phải cung cấp 1 đối số}
echo "$val"
}
```

## 14.2:Simple Function - Chức năng đơn giản

Trong helloWorld.sh
```
#!/bin/bash
# Định nghĩa một hàm greet
greet ()
{
echo "Hello World!"
}
# gọi hàm greet
greet
```

Khi chạy script, chúng tôi thấy thông điệp của chúng tôi
```
$ bash helloWorld.sh
Hello World!
```

Lưu ý rằng việc tìm nguồn cung cấp một tệp với các hàm làm cho chúng có sẵn trong phiên bash hiện tại của bạn.
```
$ source helloWorld.sh # or, more portably, ". helloWorld.sh"
$ greet
Hello World!
```

Bạn có thể xuất (export) một hàm trong một số trình bao để nó tiếp xúc với các quy trình con.
```
bash -c 'greet' # fails
export -f greet # export function; note -f
bash -c 'greet' # success
```

## 14.3:Handling flags and optional parameters - Xử lý cờ và các tham số tùy chọn

Nội trang getopts có thể được sử dụng bên trong các hàm để viết các hàm phù hợp với cờ và tùy chọnthông số. Điều này không có khó khăn đặc biệt nào nhưng người ta phải xử lý thích hợp các giá trị mà getopts chạm vào .Ví dụ, chúng tôi xác định một hàm failwith viết một thông báo trên stderr và thoát với mã 1 hoặc một mã tùy ýmã được cung cấp dưới dạng tham số cho tùy chọn -x :

```
# failwith [-x STATUS] PRINTF-LIKE-ARGV
# Không thành công với thông báo chẩn đoán đã cho
#
# Cờ -x có thể được sử dụng để chuyển tải trạng thái thoát tùy chỉnh, thay vì
# giá trị 1. Một dòng mới được tự động thêm vào đầu ra.

failwith ()
{
    local OPTIND OPTION OPTARG status

    status=1
    OPTIND=1

    while getopts 'x:' OPTION; do
        case ${OPTION} in
            x) status="${OPTARG}";;
            *) 1>&2 printf 'failwith: %s: Unsupported option.\n' "${OPTION}";;
        esac
    done

    shift $(( OPTIND - 1 ))
    {
        printf 'Failure: '
        printf "$@"
        printf '\n'
    } 1>&2
    exit "${status}"
}
```

Chức năng này có thể được sử dụng như sau:
```
failwith '%s: File not found.' "${filename}"
failwith -x 70 'General internal error.'
```
và như thế.

Lưu ý rằng đối với printf , các biến không nên được sử dụng làm đối số đầu tiên. Nếu tin nhắn cần in bao gồm nội dung của một biến, người ta nên sử dụng %s specifier để in nó, như trong

```
failwith '%s' "${message}"
```

## 14.4:Print the function definition - In định nghĩa hàm

```
getfunc() {
    declare -f "$@"
}
function func(){
    echo "I am a sample function"
}
funcd="$(getfunc func)"
getfunc func #hoặc echo "$funcd"
```

Đầu ra:
```
func ()
{
echo "I am a sample function"
}
```

## 14.5:A function that accepts named parameters - Một hàm chấp nhận các tham số được đặt tên
```
foo() {
    while [[ "$#" -gt 0 ]]
    do
        case $1 in
            -f|--follow)
                local FOLLOW="following"
                ;;
            -t|--tail)
                local TAIL="tail=$2"
                ;;
        esac
        shift
    done

    echo "FOLLOW: $FOLLOW"
    echo "TAIL: $TAIL"
}
```
Cách sử dụng ví dụ:

```
foo -f
foo -t 10
foo -f --tail 10
foo --follow --tail 10
```
## 14.6:Return value from a function - Trả về giá trị từ một hàm

Câu lệnh return trong Bash không trả về giá trị như C-functions, thay vào đó, nó thoát khỏi hàm với một giá trị trả vềtrạng thái. Bạn có thể coi nó là trạng thái thoát của chức năng đó.

Nếu bạn muốn trả về một giá trị từ hàm thì hãy gửi giá trị đến stdout như sau:
```
fun() {
    local var="Sample value to be returned"
    echo "$var"
    #printf "%s\n" "$var"
}
```
Bây giờ, nếu bạn làm:
```
var="$(fun)"
```
đầu ra của niềm vui sẽ được lưu trữ trong $ var .

## 14.7:The exit code of a function is the exit code of its last command - Mã thoát của một hàm là mã thoát củalệnh cuối cùng

Hãy xem xét chức năng ví dụ này để kiểm tra xem máy chủ có hoạt động hay không:
```
is_alive() {
    ping -c1 "$1" &> /dev/null
}
```
Hàm này sẽ gửi một ping đến máy chủ được chỉ định bởi tham số hàm đầu tiên. Đầu ra và đầu ra lỗicủa ping đều được chuyển hướng đến / dev / null , vì vậy hàm sẽ không bao giờ xuất ra bất kỳ thứ gì. Nhưng lệnh ping sẽcó mã thoát 0 khi thành công và khác 0 khi thất bại. Vì đây là lệnh cuối cùng (và trong ví dụ này là lệnh duy nhất) củahàm, mã thoát của ping sẽ được sử dụng lại cho mã thoát của chính hàm.

Thực tế này rất hữu ích trong các câu lệnh điều kiện.
Ví dụ: nếu máy chủ graucho được thiết lập, hãy kết nối với máy chủ đó bằng ssh :
```
if is_alive graucho; then
    ssh graucho
fi
```
Một ví dụ khác: liên tục kiểm tra cho đến khi máy chủ graucho hoạt động, sau đó kết nối với nó bằng ssh :
```
while ! is_alive graucho; do
    sleep 5
done
ssh graucho
```