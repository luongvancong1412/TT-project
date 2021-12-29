# Chapter 15: Bash Parameter Expansion -Mở rộng tham số Bash

- [Chapter 15: Bash Parameter Expansion -Mở rộng tham số Bash](#chapter-15-bash-parameter-expansion--mở-rộng-tham-số-bash)
  - [15.1:Modifying the case of alphabetic characters - Sửa đổi trường hợp của các ký tự chữ cái](#151modifying-the-case-of-alphabetic-characters---sửa-đổi-trường-hợp-của-các-ký-tự-chữ-cái)
  - [15.2:Length of parameter - Độ dài của tham số](#152length-of-parameter---độ-dài-của-tham-số)
  - [15.3: Replace pattern in string - Thay thế mẫu trong chuỗi](#153-replace-pattern-in-string---thay-thế-mẫu-trong-chuỗi)
  - [15.4:Substrings and subarrays - Chuỗi con và mảng con](#154substrings-and-subarrays---chuỗi-con-và-mảng-con)
  - [15.5:Delete a pattern from the beginning of a string - Xóa một mẫu khỏi đầu chuỗi](#155delete-a-pattern-from-the-beginning-of-a-string---xóa-một-mẫu-khỏi-đầu-chuỗi)
  - [15.6: Parameter indirection - Hướng tham số](#156-parameter-indirection---hướng-tham-số)
  - [15.7:Parameter expansion and filenames - Mở rộng tham số và tên tệp](#157parameter-expansion-and-filenames---mở-rộng-tham-số-và-tên-tệp)
  - [15.8:Default value substitution - Thay thế giá trị mặc định](#158default-value-substitution---thay-thế-giá-trị-mặc-định)
  - [15.9:Delete a pattern from the end of a string - Xóa một mẫu khỏi phần cuối của một chuỗi](#159delete-a-pattern-from-the-end-of-a-string---xóa-một-mẫu-khỏi-phần-cuối-của-một-chuỗi)
  - [15.10:Munging during expansion - Bôi trong quá trình mở rộng](#1510munging-during-expansion---bôi-trong-quá-trình-mở-rộng)
  - [15.11:Error if variable is empty or unset - Lỗi nếu biến trống hoặc không được đặt](#1511error-if-variable-is-empty-or-unset---lỗi-nếu-biến-trống-hoặc-không-được-đặt)


Ký tự $ giới thiệu mở rộng tham số, thay thế lệnh hoặc mở rộng số học. Thông sốtên hoặc ký hiệu được mở rộng có thể được đặt trong dấu ngoặc nhọn, là tùy chọn nhưng dùng để bảo vệ biến thànhđược mở rộng từ các ký tự ngay sau nó, có thể được hiểu là một phần của tên.
Đọc thêm trong Hướng dẫn sử dụng Bash .

## 15.1:Modifying the case of alphabetic characters - Sửa đổi trường hợp của các ký tự chữ cái

Phiên bản ≥ 4.0
Đến trường hợp trên

```
$ v="hello"
# Just the first character
$ printf '%s\n' "${v^}"
Hello
# All characters
$ printf '%s\n' "${v^^}"
HELLO
# Alternative
$ v="hello world"
$ declare -u string="$v"
$ echo "$string"
HELLO WORLD
```

Thành chữ thường

```
$ v="BYE"
# Just the first character
$ printf '%s\n' "${v,}"
bYE
# All characters
$ printf '%s\n' "${v,,}"
bye
# Alternative
$ v="HELLO WORLD"
$ declare -l string="$v"
$ echo "$string"
hello world
```

Trường hợp chuyển đổi
```
$ v="Hello World"
# All chars
$ echo "${v~~}"
hELLO wORLD
$ echo "${v~}"
# Just the first char
hello World
```

## 15.2:Length of parameter - Độ dài của tham số

```
# Length of a string
$ var='12345'
$ echo "${#var}"
5
```

Lưu ý rằng đó là độ dài tính theo số ký tự không nhất thiết phải bằng số byte (như trongUTF-8 trong đó hầu hết các ký tự được mã hóa bằng nhiều hơn một byte), cũng như số lượng glyph / grapheme (một sốlà sự kết hợp của các ký tự), cũng không nhất thiết phải giống với chiều rộng hiển thị.

```
# Số phần tử của mảng
$ myarr=(1 2 3)
$ echo "${#myarr[@]}"
3

# Cũng hoạt động cho các tham số vị trí
$ set -- 1 2 3 4
$ echo "${#@}"
4

# Nhưng phổ biến hơn (và có thể chuyển sang các trình bao khác), người ta sẽ sử dụng
$ echo "$#"
4
```

## 15.3: Replace pattern in string - Thay thế mẫu trong chuỗi


Trận đấu thứ nhất:
```
$ a='I am a string'
$ echo "${a/a/A}"
I Am a string
```
Tất cả các trận đấu:
```
$ echo "${a//a/A}"
I Am A string
```
Khớp ở đầu:
```
$ echo "${a/#I/y}"
y am a string
```

Kết hợp ở cuối:
```
$ echo "${a/%g/N}"
I am a strinN
```

Thay thế một mẫu mà không có gì:

```
$ echo "${a/g/}"
I am a strin
```

Thêm tiền tố vào các mục mảng:

```
$ A=(hello world)
$ echo "${A[@]/#/R}"
Rhello Rworld
```

## 15.4:Substrings and subarrays - Chuỗi con và mảng con

```
var = '0123456789abcdef'

# Xác định độ lệch dựa trên 
$ printf '%s\n' "${var:3}"
3456789abcdef

# Chênh lệch và độ dài của chuỗi con
$ printf '%s\n' "${var:3:4}"
3456
```

Phiên bản ≥ 4.2
```
# Số lượng độ dài âm tính từ cuối chuỗi
$ printf '%s\n' "${var:3:-5}"
3456789a

# Số lượng bù trừ âm từ cuối
# Cần khoảng trắng để tránh nhầm lẫn với $ {var: -6}
$ printf '%s\n' "${var: -6}"
abcdef

# Thay thế: dấu ngoặc đơn
$ printf '%s\n' "${var:(-6)}"
abcdef

# Độ lệch âm và độ dài âm
$ printf '%s\n' "${var: -6:-5}"
a
```

Các mở rộng tương tự cũng áp dụng nếu tham số là tham số vị trí hoặc phần tử của mảng được chỉ định con :

```
# Đặt tham số vị trí $ 1
set -- 0123456789abcdef

# Xác định độ lệch
$ printf '%s\n' "${1:5}"
56789abcdef

# Gán cho phần tử mảng
myarr[0]='0123456789abcdef'

# Xác định độ lệch và độ dài
$ printf '%s\n' "${myarr[0]:7:3}"
789
```

Mở rộng tương tự áp dụng cho các tham số vị trí , trong đó hiệu số là một dựa trên:

```
# Đặt tham số vị trí $ 1, $ 2, ...
$ set -- 1 2 3 4 5 6 7 8 9 0 a b c d e f

# Xác định độ lệch (hãy cẩn thận $ 0 (không phải là tham số vị trí)
# cũng đang được xem xét ở đây)
$ printf '%s\n' "${@:10}"
0
a
b
c
d
e
f

# Xác định độ lệch và độ dài
$ printf '%s\n' "${@:10:3}"
0
a
b

# Không cho phép độ dài âm cho các tham số vị trí
$ printf '%s\n' "${@:10:-2}"
bash: -2: substring expression < 0

# Số lượng bù trừ âm từ cuối

# Cần một khoảng trống để tránh nhầm lẫn với $ {@: - 10: 2}
$ printf '%s\n' "${@: -10:2}"
7
8

# $ {@: 0} là $ 0, nếu không thì không phải là một phần hoặc tham số vị trí
# trong số $@
$ printf '%s\n' "${@:0:2}"
/usr/bin/bash
1
```

Mở rộng chuỗi con có thể được sử dụng với các mảng được lập chỉ mục :

```
# Tạo mảng (chỉ số dựa trên 0)
$ myarr=(0 1 2 3 4 5 6 7 8 9 a b c d e f)

# Phần tử có chỉ số 5 trở lên
$ printf '%s\n' "${myarr[@]:12}"
c
d
e
f

# 3 phần tử, bắt đầu bằng chỉ số 5
$ printf '%s\n' "${myarr[@]:5:3}"
5
6
7

# Phần tử cuối cùng của mảng
$ printf '%s\n' "${myarr[@]: -1}"
f
```

## 15.5:Delete a pattern from the beginning of a string - Xóa một mẫu khỏi đầu chuỗi

Trận đấu ngắn nhất:
```
$ a='I am a string'
$ echo "${a#*a}"
m a string
```

Trận đấu dài nhất:
```
$ echo "${a##*a}"
string
```

## 15.6: Parameter indirection - Hướng tham số

Bash indirection cho phép lấy giá trị của một biến có tên được chứa trong một biến khác. Biếnthí dụ:
```
$ red="the color red"
$ green="the color green"
$ color=red
$ echo "${!color}"
the color red
$ color=green
$ echo "${!color}"
the color green
```
Một số ví dụ khác chứng minh việc sử dụng mở rộng gián tiếp:
```
$ foo=10
$ x=foo
$ echo ${x} #Classic variable print
foo

$ foo=10
$ x=foo
$ echo ${!x} #Indirect expansion
10
```

Thêm một ví dụ:

```
$ argtester () { for (( i=1; i<="$#"; i++ )); do echo "${i}";done; }; argtester -ab -cd -ef
1       #i được mở rộng thành 1
2       #i được mở rộng thành 2
3       #i được mở rộng thành 3

$ argtester () { for (( i=1; i<="$#"; i++ )); do echo "${!i}";done; }; argtester -ab -cd -ef
-ab     # i = 1 -> được mở rộng thành $ 1 ---> được mở rộng thành đối số đầu tiên được gửi đến hàm
-cd     # i = 2 -> được mở rộng thành $ 2 ---> được mở rộng thành đối số thứ hai được gửi đến hàm
-ef     # i = 3 -> được mở rộng thành $ 3 ---> được mở rộng thành đối số thứ ba được gửi đến hàm
```

## 15.7:Parameter expansion and filenames - Mở rộng tham số và tên tệp

Bạn có thể sử dụng Mở rộng tham số Bash để mô phỏng các hoạt động xử lý tên tệp phổ biến như `basename` và `dirname` .

Chúng tôi sẽ sử dụng điều này làm đường dẫn ví dụ của chúng tôi:
```
FILENAME = "/tmp/example/myfile.txt"
```
Để mô phỏng tên dirname và trả về tên thư mục của đường dẫn tệp:
```
echo "${FILENAME%/*}"
#Out: /tmp/example
```
Để mô phỏng `basename` `$FILENAME` và trả về tên tệp của đường dẫn tệp:
```
echo "${FILENAME##*/}"
#Out: myfile.txt
```

Để mô phỏng `basename` `$FILENAME` .txt và trả về tên tệp không có .txt. gia hạn:
```
BASENAME="${FILENAME##*/}"
echo "${BASENAME%%.txt}"
#Out: myfile
```

## 15.8:Default value substitution - Thay thế giá trị mặc định

>${parameter:-word}
>Nếu tham số không được đặt hoặc null, thì sự mở rộng của từ sẽ được thay thế. Nếu không, giá trị của tham số làđược thay thế.

```
$ unset var
$ echo "${var:-XX}"         # Tham số chưa được đặt -> xảy ra mở rộng XX
XX
$ var=""                    # Tham số là null -> mở rộng XX xảy ra
$ echo "${var:-XX}"
XX
$ var=23                    # Tham số không rỗng -> xảy ra mở rộng ban đầu
$ echo "${var:-XX}"
23
```

>${parameter:=word}
Nếu tham số không được đặt hoặc null, phần mở rộng của từ được gán cho tham số. Giá trị của tham số làsau đó được thay thế. Các tham số vị trí và tham số đặc biệt có thể không được gán theo cách này.

```
$ unset var
$ echo "${var:=XX}"             # Tham số chưa được đặt -> từ được gán cho XX
XX
$ echo "$var"
XX
$ var=""                        # Tham số là null -> từ được gán cho XX
$ echo "${var:=XX}"
XX
$ echo "$var"
XX
$ var=23                        # Tham số không rỗng -> không có phép gán nào xảy ra
$ echo "${var:=XX}"
23
$ echo "$var"
23
```
 
## 15.9:Delete a pattern from the end of a string - Xóa một mẫu khỏi phần cuối của một chuỗi
 
Trận đấu ngắn nhất:
```
$ a='I am a string'
$ echo "${a%a*}"
I am
```

Trận đấu dài nhất:
```
$ echo "${a%%a*}"
I
```

## 15.10:Munging during expansion - Bôi trong quá trình mở rộng

Các biến không nhất thiết phải mở rộng đến giá trị của chúng - các chuỗi con có thể được trích xuất trong quá trình mở rộng, điều nàycó thể hữu ích để giải nén phần mở rộng tệp hoặc các phần của đường dẫn. Các ký tự bóng bẩy giữ nguyên ý nghĩa thông thường của chúng, vì vậy . *đề cập đến một dấu chấm theo nghĩa đen, theo sau là bất kỳ chuỗi ký tự nào; nó không phải là một biểu thức chính quy.
```
$ v=foo-bar-baz
$ echo ${v%%-*}
foo
$ echo ${v%-*}
foo-bar
$ echo ${v##*-}
baz
$ echo ${v#*-}
bar-baz
```

Cũng có thể mở rộng một biến bằng cách sử dụng giá trị mặc định - giả sử tôi muốn gọi trình chỉnh sửa của người dùng, nhưng nếu họ khôngđặt một cái mà tôi muốn cung cấp cho họ khí lực .
```
$ EDITOR=nano
$ ${EDITOR:-vim} /tmp/some_file
# opens nano
$ unset EDITOR
$ $ ${EDITOR:-vim} /tmp/some_file
# opens vim
```
Có hai cách khác nhau để thực hiện việc mở rộng này, khác nhau ở chỗ biến có liên quan là trống hoặckhông đặt. Sử dụng : - sẽ sử dụng mặc định nếu biến không được đặt hoặc trống, trong khi - chỉ sử dụng mặc định nếu biếnbiến chưa được đặt, nhưng sẽ sử dụng biến nếu nó được đặt thành chuỗi trống:
```
$ a="set"
$ b=""
$ unset c
$ echo ${a:-default_a} ${b:-default_b} ${c:-default_c}
set default_b default_c
$ echo ${a-default_a} ${b-default_b} ${c-default_c}
set default_c
```

Tương tự như mặc định, có thể đưa ra các lựa chọn thay thế; trong đó giá trị mặc định được sử dụng nếu một biến cụ thể không khả dụng,thay thế được sử dụng nếu biến có sẵn.

```
$ a="set"
$ b=""
$ echo ${a:+alternative_a} ${b:+alternative_b}
alternative_a
```

Lưu ý rằng các phần mở rộng này có thể được lồng vào nhau, việc sử dụng các giải pháp thay thế trở nên đặc biệt hữu ích khi cung cấp đối số cho cờ dòng lệnh;
```
$ output_file=/tmp/foo
$ wget ${output_file:+"-o ${output_file}"} www.stackexchange.com
# expands to wget -o /tmp/foo www.stackexchange.com
$ unset output_file
$ wget ${output_file:+"-o ${output_file}"} www.stackexchange.com
# expands to wget www.stackexchange.com
```

## 15.11:Error if variable is empty or unset - Lỗi nếu biến trống hoặc không được đặt

Ngữ nghĩa cho điều này tương tự như ngữ nghĩa thay thế giá trị mặc định, nhưng thay vì thay thế một giá trị mặc định, nólỗi với thông báo lỗi được cung cấp. Các biểu mẫu là `${VARNAME? ERRMSG}` và `${VARNAME:? ERRMSG}` . Hình thức with : sẽ lỗi của chúng tôi nếu biến không được đặt hoặc trống , trong khi biểu mẫu không có sẽ chỉ xảy ra lỗi nếu biến làkhông đặt . Nếu xuất hiện lỗi, ERRMSG được xuất ra và mã thoát được đặt thành 1 .
```
#!/bin/bash
FOO=
# ./script.sh: line 4: FOO: EMPTY
echo "FOO is ${FOO:?EMPTY}"
# FOO is
echo "FOO is ${FOO?UNSET}"
# ./script.sh: line 8: BAR: EMPTY
echo "BAR is ${BAR:?EMPTY}"
# ./script.sh: line 10: BAR: UNSET
echo "BAR is ${BAR?UNSET}"
```

Việc chạy ví dụ đầy đủ ở trên mỗi câu lệnh echo bị lỗi cần phải được nhận xét để tiếp tục