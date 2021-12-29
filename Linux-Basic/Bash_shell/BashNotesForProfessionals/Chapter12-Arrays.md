# Chapter 12: Arrays - Mảng

## 12.1: Array Assignments - Gán mảng

**Gán danh sách**
Nếu bạn đã quen với Perl, C hoặc Java, bạn có thể nghĩ rằng Bash sẽ sử dụng dấu phẩy để phân tách các phần tử mảng,Tuy nhiên, đây không phải là trường hợp; thay vào đó, Bash sử dụng dấu cách:
```
# Array in Perl
my @array = (1, 2, 3, 4);
# Array in Bash
array=(1 2 3 4)
```

Tạo một mảng với các phần tử mới:

```
array=('phần tử đầu' 'phần tử 2' 'phần tử 3')
```

**Subscript Assignment** - Chỉ định bảng phụ

Tạo một mảng với các chỉ số phần tử rõ ràng:
```
array = ([ 3 ] = 'phần tử thứ tư' [ 4 ] = 'phần tử thứ năm' )
```
**Assignment by index** - Chỉ định theo chỉ mục
```
array [ 0 ] = 'phần tử đầu tiên'
array [ 1 ] = 'phần tử thứ hai'
```

**Assignment by name (associative array)** - Chỉ định theo tên (mảng kết hợp)

Version ≥ 4.0
```
declare -A array
array[first]='First element'
array[second]='Second element'
```

**Dynamic Assignment** - Chuyển nhượng động
Tạo một mảng từ đầu ra của lệnh khác, ví dụ: sử dụng seq để nhận phạm vi từ 1 đến 10:
```
array = ( ` seq 1 10 ' )
```
Phép gán từ các đối số đầu vào của tập lệnh:

```
array=("$@")
```

Chuyển nhượng trong các vòng lặp:
```
while read -r; do
#array+=("$REPLY") # Nối mảng
array[$i]="$REPLY" # Chỉ định theo chỉ mục
let i++ # chỉ số tăng
done < <(seq 1 10) # Thay thế lệnh
echo ${array[@]} # output: 1 2 3 4 5 6 7 8 9 10
```
trong đó $ REPLY luôn là đầu vào hiện tại

## 12.2:Accessing Array Elements - Truy cập các phần tử mảng
In phần tử ở chỉ mục 0
```
echo " $ {array [0]} "
```
Phiên bản <4.3

In phần tử cuối cùng bằng cú pháp mở rộng chuỗi con
```
echo " $ {arr [@]: -1} "
```
Phiên bản ≥ 4.3

In phần tử cuối cùng bằng cú pháp chỉ số con
```
echo " $ {array [-1]} "
```

In tất cả các phần tử, mỗi phần tử được trích dẫn riêng biệt
```
echo " $ {array [@]} "
```

In tất cả các phần tử dưới dạng một chuỗi được trích dẫn duy nhất

```
echo " $ {array [*]} "
```

In tất cả các phần tử từ chỉ mục 1, mỗi phần tử được trích dẫn riêng biệt
```
echo " $ {array [@]: 1} "
```

In 3 phần tử từ chỉ mục 1, mỗi phần tử được trích dẫn riêng biệt
```
echo " $ {array [@]: 1: 3} "
```

**String Operations** - Hoạt động chuỗi

Nếu tham chiếu đến một phần tử, các phép toán chuỗi được phép:

```
array = ( zero one two)
echo " $ {array [0]: 0: 3} " # cho ra zer (các ký tự ở vị trí 0, 1 và 2 trong chuỗi số 0)
echo " $ {array [0]: 1: 3} " # đưa ra hàm ero (các ký tự ở vị trí 1, 2 và 3 trong chuỗi số 0)
```

vì vậy: `${array[$i]:N:M}` đưa ra một chuỗi từ vị trí thứ N (bắt đầu từ 0) trong chuỗi `${array[$i]}` với M các ký tự sau.

## 12.3: Array Modification - Sửa đổi mảng
**Thay đổi chỉ mục**

Khởi tạo hoặc cập nhật một phần tử cụ thể trong mảng
```
array [ 10 ] = "phần tử thứ mười một"# vì nó bắt đầu bằng 0
```
Phiên bản ≥ 3.1
**Nối**
Sửa đổi mảng, thêm phần tử vào cuối nếu không có chỉ số con nào được chỉ định.
```
array += ( 'phần tử thứ tư' 'phần tử thứ năm' )
```


Thay thế toàn bộ mảng bằng một danh sách tham số mới.
```
array = ( " $ {array [@]} " "phần tử thứ tư" "phần tử thứ năm" )
```

Thêm một phần tử vào đầu:
```
array = ( "phần tử mới" " $ {array [@]} " )
```

**Chèn**

Chèn một phần tử tại một chỉ mục nhất định:

```
arr = ( abcd )# chèn một phần tử tại chỉ mục 2
i = 2
arr = ( " $ {arr [@]: 0: $ i} " 'mới' " $ {arr [@]: $ i} " )
echo " $ {arr [2]} " #output: mới
```

**Xóa bỏ**

Xóa chỉ mục mảng bằng cách sử dụng nội trang chưa đặt :

```
arr = ( abc )
echo " $ {arr [@]} "# đầu ra: abc
echo " $ {! arr [@]} " # đầu ra: 0 1 2
unset -v 'arr [1]'
echo " $ {arr [@]} "# đầu ra: ac
echo " $ {! arr [@]} " # đầu ra: 0 2
```

**Hợp nhất**

```
array3 = ( " $ {array1 [@]} " " $ {array2 [@]} " )
```

Điều này cũng hoạt động cho các mảng thưa thớt.

**Lập chỉ mục lại một mảng**

Điều này có thể hữu ích nếu các phần tử đã bị xóa khỏi một mảng hoặc nếu bạn không chắc liệu có khoảng trống trong mảng. Để tạo lại các chỉ số mà không có khoảng trống:

```
array = ( " $ {array [@]} " )
```

## 12.4: Array Iteration - Lặp lại mảng

Lặp lại mảng có hai loại, foreach và for-loop cổ điển:

```
a = ( 1 2 3 4 )
# vòng lặp foreach
for y in "${a[@]}"; do
    #act on $y
    echo "$y"
done
# classic for-loop
for ((idx=0; idx < ${#a[@]}; ++idx)); do
    # act on ${a[$idx]}
    echo "${a[$idx]}"
done
```
Bạn cũng có thể lặp lại đầu ra của một lệnh:
```
a=($(tr ',' ' ' <<<"a,b,c,d")) #tr có thể biến đổi ký tự này thành ký tự khác
for y in "${a[@]}"; do
    echo "$y"
done
```

## 12.5: Array Length - Độ dài mảng

`$ {# array [@]} `cung cấp độ dài của mảng `$ {array [@]}` :

```
array = ( 'phần tử đầu tiên' 'phần tử thứ hai' 'phần tử thứ ba' )
echo " $ {# array [@]} " # có độ dài là 3
```

Điều này cũng hoạt động với các Chuỗi trong các phần tử đơn lẻ:

```
echo " $ {# mảng [0]} "# đưa ra chiều dài của chuỗi ở phần tử 0: 13
```

## 12.6: Associative Arrays - Mảng liên kết

Phiên bản ≥ 4.0
Khai báo một mảng kết hợp

```
declare -A aa
```

Việc khai báo một mảng kết hợp trước khi khởi tạo hoặc sử dụng là bắt buộc.

**Khởi tạo các phần tử**

Bạn có thể khởi tạo từng phần tử một như sau:

```
aa[hello]=world
aa[ab]=cd
aa["key with space"]="hello world"
```

Bạn cũng có thể khởi tạo toàn bộ một mảng kết hợp trong một câu lệnh:

```
aa = ([ hello ] = world [ ab ] = cd [ "key with space" ] = "hello world" )
```

**Truy cập một phần tử mảng kết hợp**

```
echo ${aa[hello]}
# Out: world
```

**Liệt kê các khóa mảng kết hợp**

```
echo " $ {! aa [@]} "
#Out: hello ab key with space
```

**Liệt kê các giá trị mảng kết hợp**

```
echo " $ {aa [@]} "
#Out: world cd hello world
```

**Lặp lại các khóa và giá trị mảng kết hợp**

```
for key in "${!aa[@]}"; do
    echo "Key: ${key}"
    echo "Value: ${array[$key]}"
done

# Out:
# Key: hello
# Value: world
# Key: ab
# Value: cd
# Key: key with space
# Value: hello world
```

**Đếm phần tử mảng kết hợp**

```
echo "${#aa[@]}"
# Out: 3
```

## 12.7: Looping through an array - Vòng qua một mảng

Mảng ví dụ của chúng tôi:

```
arr = ( abcdef )
```

Sử dụng vòng lặp for..in :

```
for i in "${arr[@]}"; do
    echo "$i"
done
```
Phiên bản ≥ 2.04

Sử dụng C-style for loop:

```
for ((i=0;i<${#arr[@]};i++)); do
    echo "${arr[$i]}"
done
```

Sử dụng vòng lặp while:

```
i=0
while [ $i -lt ${#arr[@]} ]; do
    echo "${arr[$i]}"
    i=$((i + 1))
done
```
Version ≥ 2.04

Sử dụng vòng lặp while với điều kiện số:

```
i=0
while (( $i < ${#arr[@]} )); do
    echo "${arr[$i]}"
    ((i++))
done
```

Sử dụng vòng lặp `until` :

```
i=0
until [ $i -ge ${#arr[@]} ]; do
    echo "${arr[$i]}"
    i=$((i + 1))
done
```
Phiên bản ≥ 2.04

Sử dụng vòng lặp until có điều kiện số:

```
i=0
until (( $i >= ${#arr[@]} )); do
    echo "${arr[$i]}"
    ((i++))
done
```

## 12.8:Destroy, Delete, or Unset an Array - Hủy, Xóa hoặc Hủy đặt một mảng

Để hủy, xóa hoặc hủy đặt một mảng:

```
unset array
```

Để hủy, xóa hoặc hủy đặt một phần tử mảng:

```
unset array
```

## 12.9:Array from string - Mảng từ chuỗi

```
stringVar="Apple Orange Banana Mango"
arrayVar=(${stringVar// / })
```

Mỗi khoảng trắng trong chuỗi biểu thị một mục mới trong mảng kết quả.
```
echo ${arrayVar[0]} # will print Apple
echo ${arrayVar[3]} # will print Mango
```

Tương tự, các ký tự khác có thể được sử dụng cho dấu phân cách.
```
stringVar="Apple+Orange+Banana+Mango"
arrayVar=(${stringVar//+/ })
echo ${arrayVar[0]} # will print Apple
echo ${arrayVar[2]} # will print Banana
```
## 12.10:List of initialized indexes - Danh sách các chỉ mục được khởi tạo

Lấy danh sách các chỉ mục được vô hiệu hóa trong một mảng

```
$ arr[2]='second'
$ arr[10]='tenth'
$ arr[25]='twenty five'
$ echo ${!arr[@]}
2 10 25
```

## 12.11:Reading an entire file into an array - Đọc toàn bộ tệp thành một mảng

Đọc trong một bước duy nhất:
```
IFS=$'\n' read -r -a arr < file
```

Đọc trong một vòng lặp:
```
arr=()
while IFS= read -r line; do
    arr+=("$line")
done
```
Version ≥ 4.0

Sử dụng mapfile hoặc readarray (đồng nghĩa với nhau):
```
mapfile -t arr < file
readarray -t arr < file
```

## 12.12:Array insert function - Hàm chèn mảng

Hàm này sẽ chèn một phần tử vào một mảng tại một chỉ mục nhất định:

```
insert(){
h='
################## insert ########################
# Usage:
#   insert  phần tử mục arr_name
#
# Thông số:
# arr_name : Tên của biến mảng
# index : Chỉ mục để chèn vào
# element : Phần tử cần chèn
##################################################
    '
    [[ $1 = -h ]] && { echo "$h" >/dev/stderr; return 1; }
    declare -n __arr__=$1 # Tham chiếu đến biến mảng
    i=$2 # chỉ mục để chèn tại
    el="$3" # phần tử để chèn
    # xử lý errors
    [[ ! "$i" =~ ^[0-9]+$ ]] && { echo "E: insert: index phải là một số nguyên hợp lệ" >/dev/stderr;
return 1; }
    (( $1 < 0 )) && { echo "E: insert: index không được âm" >/dev/stderr; return 1; }
    # Bây giờ hãy chèn $el tại $i
    __arr__=("${__arr__[@]:0:$i}" "$el" "${__arr__[@]:$i}")
}
```

Sử dụng:

```
insert array_variable_name index element
```

Ex:
```
arr = ( abcd )
echo " $ {arr [2]} " # đầu ra: c
# Bây giờ hãy gọi hàm insert và chuyển tên biến mảng,
# chỉ mục để chèn tại
# và phần tử cần chèn
insert arr 2 'New Element'
# 'Phần tử Mới' đã được chèn ở chỉ mục 2 trong arr, bây giờ hãy in chúng
echo " $ {arr [2]} " # đầu ra: Phần tử mới
echo " $ {arr [3]} " # đầu ra: c
```