# Chapter 45: Word splitting - Tách từ

Tham số| Thông tin chi tiết|
|---|---|
IFS|Dấu tách trường nội bộ|
-x|In các lệnh và đối số của chúng khi chúng được thực thi (Tùy chọn Shell)|

## 45.1: Cái gì, khi nào và tại sao? - What, when and Why?

Khi này thực hiện shell tham số mở rộng , thay thế lệnh , thay đổi hoặc mở rộng số học , nó sẽ quétranh giới từ trong kết quả. Nếu tìm thấy bất kỳ ranh giới từ nào, thì kết quả sẽ được chia thành nhiều từ tại đóChức vụ. Ranh giới từ được xác định bởi một biến shell IFS (Internal Field Separator). Giá trị mặc định cho IFSlà dấu cách, tab và dòng mới, tức là việc tách từ sẽ xảy ra trên ba ký tự khoảng trắng này nếu không được ngăn chặnmột cách rõ ràng.

```
set -x
var='I am
a
multiline string'
fun() {
    echo "-$1-"
    echo "*$2*"
    echo ".$3."
}
fun $var
```

Trong ví dụ trên, đây là cách hàm fun đang được thực thi:

```
fun I am a multiline string
```

>$ var được chia thành 5 args, chỉ I , am và a sẽ được in.

## 45.2: Các hiệu ứng xấu của việc tách từ - Bad eects of word splitting

```
$ a='I am a string with spaces'
$ [ $a = $a ] || echo "didn't match"
bash: [: too many arguments
didn't match
```

>`[ $a = $a ]` được hiểu là [ Tôi là một chuỗi có dấu cách = Tôi là một chuỗi có dấu cách ] . [ là các thử nghiệm lệnh mà tôi là một chuỗi với không gian không phải là một đối số duy nhất, chứ không phải đó là 6 tranh luận!!

```
$ [ $a = something ] || echo "didn't match"
bash: [: too many arguments
didn't match
```

>[ $a = something ] được hiểu là [ Tôi là một chuỗi có dấu cách = cái gì đó ]

```
$ [ $(grep . file) = 'something' ]
bash: [: too many arguments
```

>Lệnh grep trả về một chuỗi nhiều dòng có dấu cách, vì vậy bạn có thể hình dung có bao nhiêu đối sốcó ...:D

Xem những gì, khi nào và tại sao để biết những điều cơ bản.

## 45.3: Tính hữu dụng của việc tách từ - Usefulness of word splitting

Có một số trường hợp tách từ có thể hữu ích:

Làm đầy mảng:

```
arr=($(grep -o '[0-9]\+' file))
```

>Điều này sẽ điền vào arr với tất cả các giá trị số được tìm thấy trong tệp

Vòng qua các từ được phân cách bằng dấu cách:

```
words='foo bar baz'
for w in $words;do
    echo "W: $w"
done
```

Đầu ra:

```
W: foo
W: bar
W: baz
```

Chuyển các tham số được phân tách bằng dấu cách không chứa khoảng trắng:

```
packs='apache2 php php-mbstring php-mysql'
sudo apt-get install $packs
```

hoặc là

```
packs='
apache2
php
php-mbstring
php-mysql
'
sudo apt-get install $packs
```

>Điều này sẽ cài đặt các gói. Nếu bạn trích dẫn gấp đôi các gói $ thì nó sẽ xuất hiện một lỗi.

>Unquoetd `$pack` đang gửi tất cả các tên gói được phân tách bằng dấu cách làm đối số tới apt-get , trong khitrích dẫn nó sẽ gửi chuỗi $ pack dưới dạng một đối số và sau đó apt-get sẽ cố gắng cài đặt một góicó tên là apache2 php php-mbstring php-mysql (dành cho cái đầu tiên) rõ ràng là không tồn tại

Xem những gì, khi nào và tại sao để biết những điều cơ bản.

## 45.4: Phân tách bằng các thay đổi về dấu phân tách - Splitting by separator changes

Chúng ta chỉ có thể thực hiện thay thế đơn giản các dấu phân cách từ khoảng trắng sang dòng mới, như ví dụ sau.

```
echo $sentence | tr " " "\n"
```

Nó sẽ chia nhỏ giá trị của câu biến và hiển thị từng dòng một.

## 45.5: Tách với IFS

Để rõ ràng hơn, hãy tạo một tập lệnh có tên showarg :

```
#!/usr/bin/env bash
printf "%d args:" $#
printf " <%s>" "$@"
echo
```

Bây giờ chúng ta hãy xem sự khác biệt:

```
$ var="This is an example"
$ showarg $var
4 args: <This> <is> <an> <example>
```
>$ var được chia thành 4 args. IFS là các ký tự khoảng trắng và do đó việc tách từ xảy ra trong khoảng trắng

```
$ var="This/is/an/example"
$ showarg $var
1 args: <This/is/an/example>
```

>Ở trên không xảy ra tách từ vì không tìm thấy ký tự IFS .

Bây giờ hãy đặt IFS =/

```
$ IFS=/
$ var="This/is/an/example"
$ showarg $var
4 args: <This> <is> <an> <example>
```

>Các $ var là tách thành 4 đối số không phải là một đối số duy nhất.

## 45.6: IFS & tách từ - IFS & word splitting

Xem điều gì, khi nào và tại sao nếu bạn không biết về mối liên hệ của IFS với tách từ

**hãy đặt IFS chỉ ký tự khoảng trắng:**

```
set -x
var='I am
a
multiline string'
IFS=' '
fun() {
echo "-$1-"
echo "*$2*"
echo ".$3."
}
fun $var
```

Việc tách từ theo thời gian này sẽ chỉ hoạt động trên dấu cách. Hàm fun sẽ được thực thi như thế này:

```
fun I 'am
a
multiline' string
```

>$ var được chia thành 3 args. I,am\na\nmultiline và chuỗi sẽ được in

**Hãy đặt IFS chỉ thành dòng mới:**

```
IFS=$'\n'
...
```

Bây giờ niềm vui sẽ được thực hiện như:

```
fun 'I am' a 'multiline string'
```
>$ var được chia thành 3 args. I am , a , chuỗi nhiều dòng sẽ được in

**Hãy xem điều gì sẽ xảy ra nếu chúng ta đặt IFS thành nullstring:**

```
IFS =
...
```

Lần này niềm vui sẽ được thực hiện như thế này:

```
fun 'I am
a
multiline string'
```

>$ var không được chia tức là nó vẫn là một đối số duy nhất.

**Bạn có thể ngăn tách từ bằng cách đặt IFS thành nullstring**

**Một cách chung để ngăn tách từ là sử dụng dấu ngoặc kép:**

```
fun "$var"
```

sẽ ngăn chặn việc tách từ trong tất cả các trường hợp được thảo luận ở trên, tức là hàm fun sẽ được thực thi chỉ với một lý lẽ.