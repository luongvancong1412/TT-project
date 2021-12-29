# Chapter 39: Read a file (data stream, variable) line-by-line (and/or field-byfield)? - Đọc tệp (luồng dữ liệu,biến) từng dòng (và / hoặc trường theo-cánh đồng)?

Tham số| Thông tin chi tiết|
|---|---|
IFS|Dấu tách trường nội bộ
file|Tên / đường dẫn tệp
-r|Ngăn giải thích dấu gạch chéo ngược khi được sử dụng với read
-t|Loại bỏ một dòng mới ở cuối khỏi mỗi dòng được đọc bởi readarray
-d DELIM|Tiếp tục cho đến khi ký tự đầu tiên của DELIM được đọc (có đọc ), thay vì dòng mới|

## 39.1: Lặp qua từng dòng một tệp - Looping through a file line by line

```
while IFS= read -r line; do
    echo "$line"
done <file
```

Nếu tệp có thể không bao gồm một dòng mới ở cuối, thì:

```
while IFS= read -r line || [ -n "$line" ]; do
    echo "$line"
done <file
```

## 39.2: Vòng qua đầu ra của trường lệnh theo lĩnh vực - Looping through the output of a command field by field

Giả sử rằng dấu phân tách trường là :

```
while IFS= read -d : -r field || [ -n "$field" ];do
    echo "**$field**"
done < <(ping google.com)
```

Hoặc với một đường ống:

```
ping google.com | while IFS= read -d : -r field || [ -n "$field" ];do
    echo "**$field**"
done
```

## 39.3: Đọc các dòng của một tệp thành một mảng - Read lines of a file into an array

```
readarray -t arr <file
```

Hoặc với một vòng lặp:

```
arr=()
while IFS= read -r line; do
    arr+=("$line")
done <file
```

## 39.4: Đọc các dòng của một chuỗi thành một mảng - Read lines of a string into an array

```
var='line 1
line 2
line3'
readarray -t arr <<< "$var"
```

hoặc với một vòng lặp:

```
arr=()
while IFS= read -r line; do
    arr+=("$line")
done <<< "$var"
```

## 39.5: Vòng qua một chuỗi từng dòng

```
var='line 1
line 2
line3'
while IFS= read -r line; do
    echo "-$line-"
done <<< "$var"
```

hoặc là

```
readarray -t arr <<< "$var"
for i in "${arr[@]}";do
    echo "-$i-"
done
```

## 39.6: Vòng qua đầu ra của một dòng lệnh theo dòng - Looping through the output of a command line by line

```
while IFS= read -r line;do
    echo "**$line**"
done < <(ping google.com)
```

hoặc với một đường ống:

```
ping google.com |
while IFS= read -r line;do
    echo "**$line**"
done
```

## 39.7: Đọc một trường tệp theo trường - Read a file field by field

Giả sử rằng dấu phân cách trường là : (dấu hai chấm) trong tệp file.

```
while IFS= read -d : -r field || [ -n "$field" ]; do
    echo "$field"
done <file
```

Đối với một nội dung:

```
first : se
con
d:
    Thi rd:
    Fourth
```

Đầu ra là:

```
**first **
** se
con
d**
**
    Thi rd**
**
    Fourth
**
```

## 39.8: Đọc một trường chuỗi theo trường - Read a string field by field

Giả sử rằng dấu phân tách trường là :

```
var='line: 1
line: 2
line3'
while IFS= read -d : -r field || [ -n "$field" ]; do
    echo "-$field-"
done <<< "$var"
```

Đầu ra:

```
-line-
- 1
line-
- 2
line3
-
```

## 39.9: Đọc các trường của một tệp thành một mảng - Read fields of a file into an array

Giả sử rằng dấu phân tách trường là :

```
arr=()
while IFS= read -d : -r field || [ -n "$field" ]; do
    arr+=("$field")
done <file
```

## 39.10: Đọc các trường của một chuỗi thành một mảng - Read fields of a string into an array

Giả sử rằng dấu phân tách trường là :

```
var='1:2:3:4:
newline'
arr=()
while IFS= read -d : -r field || [ -n "$field" ]; do
    arr+=("$field")
done <<< "$var"
echo "${arr[4]}"
```

Đầu ra:

```
newline
```

## 39.11: Đọc tệp (/ etc / passwd) từng dòng và trường theo cánh đồng - Reads file (/etc/passwd) line by line and field by field

```
#!/bin/bash
FILENAME="/etc/passwd"
while IFS=: read -r username password userid groupid comment homedir cmdshell
do
    echo "$username, $userid, $comment $homedir"
done < $FILENAME
```

Trong tệp mật khẩu unix, thông tin người dùng được lưu trữ từng dòng, mỗi dòng bao gồm thông tin của một người dùng được phân táchbởi ký tự dấu hai chấm (:). Trong ví dụ này trong khi đọc từng dòng tệp, dòng cũng được chia thành các trường bằng cách sử dụng dấu hai chấmký tự là dấu phân cách được biểu thị bằng giá trị cho IFS.

**Đầu vào mẫu**

```
mysql:x:27:27:MySQL Server:/var/lib/mysql:/bin/bash
pulse:x:497:495:PulseAudio System Daemon:/var/run/pulse:/sbin/nologin
sshd:x:74:74:Privilege-separated SSH:/var/empty/sshd:/sbin/nologin
tomcat:x:91:91:Apache Tomcat:/usr/share/tomcat6:/sbin/nologin
webalizer:x:67:67:Webalizer:/var/www/usage:/sbin/nologin
```

**Đầu ra mẫu**

```
mysql, 27, MySQL Server /var/lib/mysql
pulse, 497, PulseAudio System Daemon /var/run/pulse
sshd, 74, Privilege-separated SSH /var/empty/sshd
tomcat, 91, Apache Tomcat /usr/share/tomcat6
webalizer, 67, Webalizer /var/www/usage
```

Để đọc từng dòng và gán toàn bộ dòng cho biến, sau đây là phiên bản sửa đổi của ví dụ.Lưu ý rằng chúng tôi chỉ có một biến theo dòng tên được đề cập ở đây.

```
#!/bin/bash
FILENAME="/etc/passwd"
while IFS= read -r line
do
    echo "$line"
done < $FILENAME
```

**Đầu vào mẫu**

```
mysql:x:27:27:MySQL Server:/var/lib/mysql:/bin/bash
pulse:x:497:495:PulseAudio System Daemon:/var/run/pulse:/sbin/nologin
sshd:x:74:74:Privilege-separated SSH:/var/empty/sshd:/sbin/nologin
tomcat:x:91:91:Apache Tomcat:/usr/share/tomcat6:/sbin/nologin
webalizer:x:67:67:Webalizer:/var/www/usage:/sbin/nologin
```

**Đầu ra mẫu**

```
mysql:x:27:27:MySQL Server:/var/lib/mysql:/bin/bash
pulse:x:497:495:PulseAudio System Daemon:/var/run/pulse:/sbin/nologin
sshd:x:74:74:Privilege-separated SSH:/var/empty/sshd:/sbin/nologin
tomcat:x:91:91:Apache Tomcat:/usr/share/tomcat6:/sbin/nologin
webalizer:x:67:67:Webalizer:/var/www/usage:/sbin/nologin
```