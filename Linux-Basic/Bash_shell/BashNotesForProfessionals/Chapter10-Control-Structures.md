# Chapter 10: Control Structures

|Tham số |Thông tin chi tiết|
|---|---|
**Toán tử tệp**|Details|
-e "$file"|Trả về true nếu tệp tồn tại
-d "$file"|Trả về true nếu tệp tồn tại và là một thư mục
-f "$file"|Trả về true nếu tệp tồn tại và là tệp thông thường
-h "$file"|Trả về true nếu tệp tồn tại và là một liên kết tượng trưng
**Bộ so sánh chuỗi**|Details|
-z "$str"| Đúng nếu độ dài của chuỗi bằng 0
-n "$str"| Đúng nếu độ dài của chuỗi khác 0
"$str"="$str2"|Đúng nếu chuỗi "$str" bằng chuỗi "$str2". Không tốt nhất cho số nguyên. Nó có thể hoạt động nhưng sẽmâu thuẫn
"$str" !="$str2"|Đúng nếu các chuỗi không bằng nhau
**Bộ so sánh số nguyên**|Details|
"$int1" -eq "$int2"|Đúng nếu các số nguyên bằng nhau
"$int1" -ne "$int2"|Đúng nếu các số nguyên không bằng
"$int1" -gt "$int2"|Đúng nếu int1 lớn hơn int 2
"$int1" -ge "$int2"|Đúng nếu int1 lớn hơn hoặc bằng int2
"$int1" -lt "$int2"|Đúng nếu int1 nhỏ hơn int2
"$int1" -le "$int2"|Đúng nếu int1 nhỏ hơn hoặc bằng int2

## 10.1: Conditional execution of command lists - Thực hiện có điều kiện danh sách lệnh

Cách sử dụng thực thi có điều kiện của danh sách lệnh
Bất kỳ lệnh, biểu thức hoặc hàm nội trang nào cũng như bất kỳ lệnh hoặc tập lệnh bên ngoài nào đều có thể được thực thisử dụng có điều kiện && (và) và || (hoặc) các toán tử.
Ví dụ, điều này sẽ chỉ in thư mục hiện tại nếu lệnh cd thành công.
```
cd my_directory && pwd
```
Tương tự như vậy, điều này sẽ thoát ra nếu lệnh cd không thành công, ngăn chặn thảm họa:
```
cd my_directory || exit
rm -rf *
```
Khi kết hợp nhiều câu lệnh theo cách này, điều quan trọng cần nhớ là (không giống như nhiều kiểu Cngôn ngữ) các toán tử này không được ưu tiên và có liên kết trái.

Do đó, câu lệnh này sẽ hoạt động như mong đợi ...
```
cd my_directory && pwd || echo "No such directory"
```

- Nếu cd thành công, && pwd thực thi và tên thư mục làm việc hiện tại được in. Trừ khi pwd không thành công (ahiếm) cái || echo ... sẽ không được thực thi.
- Nếu cd không thành công, && pwd sẽ bị bỏ qua và dấu || echo ... sẽ chạy.

Nhưng điều này sẽ không (nếu bạn đang nghĩ nếu ... thì ... khác ) .

```
cd my_directory && ls || echo "No such directory"
```

- Nếu cd không thành công, && ls bị bỏ qua và dấu || echo ... được thực thi.
- Nếu cd thành công, && ls được thực thi.
  - Nếu ls thành công, || echo ... bị bỏ qua. (càng xa càng tốt)
  - NHƯNG ... nếu ls không thành công, || echo ... cũng sẽ được thực thi.
    >Đó là ls , không phải cd , là lệnh trước đó 

**Tại sao sử dụng thực thi có điều kiện của danh sách lệnh**

Thực thi có điều kiện nhanh hơn nếu ... thì nhưng lợi thế chính của nó là cho phép các chức năng và tập lệnh thoát sớm, hoặc "ngắn mạch".

Không giống như nhiều ngôn ngữ như C , nơi bộ nhớ được cấp phát rõ ràng cho các cấu trúc và biến và như vậy (và do đóphải được phân bổ), bash xử lý điều này dưới các bìa. Trong hầu hết các trường hợp, chúng tôi không phải dọn dẹp bất cứ thứ gì trước đórời khỏi chức năng. Một câu lệnh trả về sẽ phân bổ mọi thứ cục bộ cho hàm và thực thi nhận tạitrả về địa chỉ trên ngăn xếp.

Trở về từ các chức năng hoặc thoát tập lệnh càng sớm càng tốt, do đó có thể cải thiện đáng kể hiệu suất vàgiảm tải hệ thống bằng cách tránh thực thi mã không cần thiết. Ví dụ...

```
my_function () {
### ALWAYS CHECK THE RETURN CODE
# one argument required. "" evaluates to false(1)
[[ "$1" ]] || return 1
# work with the argument. exit on failure
do_something_with "$1" || return 1
do_something_else || return 1
# Success! no failures detected, or we wouldn't be here
return 0
}
```

## 10.2: If statement - Câu lệnh if
```
if [[ $1 -eq 1 ]]; then
echo "1 was passed in the first parameter"
elif [[ $1 -gt 2 ]]; then
echo "2 was not passed in the first parameter"
else
echo "The first parameter was not 1 and is not more than 2."
fi
```

Đóng fi là cần thiết, nhưng có thể bỏ qua mệnh đề elif và / hoặc các mệnh đề khác .
Dấu chấm phẩy trước đó là cú pháp tiêu chuẩn để kết hợp hai lệnh trên một dòng; chúng có thể được bỏ quachỉ khi sau đó được chuyển sang dòng tiếp theo.
Điều quan trọng là phải hiểu rằng dấu ngoặc [[ không phải là một phần của cú pháp, nhưng được coi như một lệnh; nó làthoát mã khỏi lệnh đang được kiểm tra này. Do đó, bạn phải luôn bao gồm các khoảng trắng xung quanh dấu ngoặc.

Điều này cũng có nghĩa là kết quả của bất kỳ lệnh nào cũng có thể được kiểm tra. Nếu mã thoát khỏi lệnh là số 0,tuyên bố được coi là đúng.

if grep "foo" bar.txt; sau đóecho "foo đã được tìm thấy"khácecho "không tìm thấy foo"fi

Các biểu thức toán học, khi được đặt bên trong dấu ngoặc kép, cũng trả về 0 hoặc 1 theo cách tương tự và có thểcũng được kiểm tra:

if (( $ 1 + 5 > 91 )) ; sau đóecho "$ 1 lớn hơn 86"fi

Bạn cũng có thể đi qua nếu báo cáo với dấu ngoặc đơn. Chúng được định nghĩa trong tiêu chuẩn POSIX vàđược đảm bảo hoạt động trong tất cả các trình bao tương thích với POSIX bao gồm cả Bash. Cú pháp rất giống với cú pháp trong Bash:

if [ "$ 1" -eq 1 ] ; sau đóecho "1 đã được truyền trong tham số đầu tiên"elif [ "$ 1" -gt 2 ] ; sau đóecho "2 không được chuyển trong tham số đầu tiên"khácecho "Tham số đầu tiên không phải là 1 và không lớn hơn 2."fi


## 10.3: Looping over an array - Vòng qua một mảng

vòng lặp for :arr = ( abcdef )cho tôi trong " $ {arr [@]} " ; làmecho " $ i "xongHoặcfor (( i = 0; i < $ {# arr [@]} ; i ++ )) ; làmecho " $ {arr [$ i]} "xongvòng lặp trong khi :i = 0trong khi [ $ i -lt $ {# arr [@]} ] ; làmecho " $ {arr [$ i]} "i = $ ( expr $ i + 1 )xongHoặci = 0while (( $ i < $ {# arr [@]} )) ; làmecho " $ {arr [$ i]} "(( i ++ ))

## 10.4: Using For Loop to List Iterate Over Numbers - Sử dụng vòng lặp For để liệt kê Lặp lại trên các số

#! / bin / bashcho tôi trong { 1..10 } ; do # {1..10} mở rộng thành "1 2 3 4 5 6 7 8 9 10"echo $ ixong

Điều này cho kết quả như sau:
1
2
3
4
5
6
7
8
8
10

## 10.5: continue and break - tiếp tục và ngắt

Ví dụ cho tiếp tục

cho tôi trong [ loạt ]làmlệnh 1lệnh 2if ( condition ) # Điều kiện để nhảy qua lệnh 3tiếp tục # bỏ qua đến giá trị tiếp theo trong "chuỗi"filệnh 3xong

Ví dụ cho break

cho tôi trong [ loạt ]làmlệnh 4if ( điều kiện ) # Điều kiện để phá vỡ vòng lặpsau đólệnh 5 # Lệnh nếu vòng lặp cần được phá vỡnghỉfilệnh 6 # Lệnh chạy nếu "điều kiện" không bao giờ đúngxong


##  10.6: Loop break - Ngắt vòng lặp

Ngắt nhiều vòng lặp:

arr = ( abcdef )cho tôi trong " $ {arr [@]} " ; làmecho " $ i "

cho j trong " $ {arr [@]} " ; làmecho " $ j "nghỉ 2xongxong

Đầu ra:
Một
Một

Ngắt vòng lặp đơn:
arr = ( abcdef )cho tôi trong " $ {arr [@]} " ; làmecho " $ i "cho j trong " $ {arr [@]} " ; làmecho " $ j "nghỉxongxong

Đầu ra:
Một
Một
NS
Một
NS
Một
NS
Một
e
Một
NS
Một

## 10.7: While Loop - Vòng lặp trong khi
#! / bin / bashi = 0trong khi [ $ i -lt 5 ] #While tôi nhỏ hơn 5làmecho "Tôi hiện là $ i "i = $ [ $ i +1 ] #Không thiếu khoảng trắng xung quanh dấu ngoặc. Điều này làm cho nó không phải là một biểu thức kiểm tradone #ends vòng lặp

Chú ý rằng có khoảng trống xung quanh dấu ngoặc trong quá trình kiểm tra (sau câu lệnh while). Những không gian này làcần thiết.

Vòng lặp này xuất ra:
tôi hiện tại là 0
tôi hiện là 1
tôi hiện tại là 2
tôi hiện 3 tuổi
tôi hiện 4 tuổi

## 10.8: For Loop with C-style syntax - Đối với vòng lặp với cú pháp kiểu C

Định dạng cơ bản của C-style for loop là:
for (( gán biến; điều kiện; quá trình lặp ))
Ghi chú:
Việc gán biến bên trong vòng lặp C-style for có thể chứa các khoảng trắng không giống như phép gán thông thườngCác biến bên trong vòng lặp for kiểu C không được đặt trước $ .
Thí dụ:
for (( i = 0; i < 10; i ++ ))làmecho "Số lần lặp là $ i "xong

Ngoài ra, chúng ta có thể xử lý nhiều biến bên trong C-style for loop:

for (( i = 0, j = 0; i < 10; i ++, j = i * i ))làmecho "Hình vuông của $ i bằng $ j "xong

## 10.9: Until Loop - Vòng lặp Cho đến khi

Vòng lặp Until thực thi cho đến khi điều kiện là true

i = 5cho đến khi [[ i -eq 10 ]] ; thực hiện #Checks nếu tôi = 10echo "i = $ i " # In giá trị của tôii = $ (( i + 1 )) #Increment i lên 1xong

Đầu ra:
i = 5
i = 6
i = 7
i = 8
i = 9

Khi tôi đạt đến 10, điều kiện trong vòng lặp cho đến khi trở thành đúng và vòng lặp kết thúc.

## 10.10: Switch statement with case - Chuyển câu lệnh với chữ hoa

Với câu lệnh trường hợp, bạn có thể so khớp các giá trị với một biến.

Đối số được truyền cho trường hợp được mở rộng và cố gắng khớp với từng mẫu.

Nếu một kết quả phù hợp được tìm thấy, các lệnh tối đa ;; được thực thi.

trường hợp " $ BASH_VERSION " trong[ 34 ] * )vọng lại { 1..4 };;* )seq -s "" 1 4esac

Mẫu không phải là biểu thức chính quy mà là đối sánh mẫu bao (hay còn gọi là quả địa cầu).

## 10.11: For Loop without a list-of-words parameter - Đối với Vòng lặp không có tham số danh sách từ

cho cãi; làmecho arg = $ argxong

Một cho vòng lặp mà không có một danh sách các từ thông số sẽ lặp qua các tham số vị trí để thay thế. Nói cách khác,ví dụ trên tương đương với mã này:

for arg trong "$ @" ; làmecho arg = $ argxong

Nói cách khác, nếu bạn bắt gặp mình đang viết cho tôi trong "$ @" ; làm ...; thực hiện , chỉ việc kéo thả trong một phần, và viết đơn giảncho tôi; làm ...; đã xong
