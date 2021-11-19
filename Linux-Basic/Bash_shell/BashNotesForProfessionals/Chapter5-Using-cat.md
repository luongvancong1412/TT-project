# Chapter 5: Using cat

- [Chapter 5: Using cat](#chapter-5-using-cat)
  - [Section 5.1: Concatenate files (Nối các tệp)](#section-51-concatenate-files-nối-các-tệp)
  - [Section 5.2: Printing the Contents of a File (In nội dung của tệp)](#section-52-printing-the-contents-of-a-file-in-nội-dung-của-tệp)
  - [Section 5.3: Write to a file (Ghi vào tệp)](#section-53-write-to-a-file-ghi-vào-tệp)
  - [Section 5.4: Show non printable characters (Hiển thị các ký tự không in được)](#section-54-show-non-printable-characters-hiển-thị-các-ký-tự-không-in-được)
  - [Section 5.5: Read from standard input (Đọc từ đầu vào chuẩn)](#section-55-read-from-standard-input-đọc-từ-đầu-vào-chuẩn)
  - [Section 5.6: Display line numbers with output (Hiển thị số dòng với đầu ra)](#section-56-display-line-numbers-with-output-hiển-thị-số-dòng-với-đầu-ra)
  - [Section 5.7: Concatenate gzipped files (Nối các tệp đã nén)](#section-57-concatenate-gzipped-files-nối-các-tệp-đã-nén)

|Option|Mô tả|
|---|---|
-n| In số dòng
-v| Hiển thị các ký tự không in bằng ký hiệu ^ và M- ngoại trừ LFD và TAB
-T|Hiển thị các ký tự TAB dưới dạng ^I
-E|Hiển thị các ký tự trong nguồn cấp dữ liệu dòng (LF) dưới dạng $
-e|Giống -vE
-b|Đánh số các dòng đầu ra không có gì, ghi đè -n
-A|tương đương với -vET
-s|ngăn chặn các dòng đầu ra trống lặp đi lặp lại, s đề cập đến ép.|

## Section 5.1: Concatenate files (Nối các tệp)
Đây là mục đích chính của cat.
```
cat file1 file2 file3 > file_all
```

```cat``` cũng có thể được sử dụng tương tự để nối các tệp như một phần của đường dẫn, ví dụ:

```
cat file1 file2 file3 | grep foo
```

## Section 5.2: Printing the Contents of a File (In nội dung của tệp)


```cat file.txt```

sẽ in nội dung của một tệp.
Nếu tệp chứa các ký tự không phải ASCII, bạn có thể hiển thị các ký tự đó một cách tượng trưng bằng cat -v . Điều này có thể làkhá hữu ích cho các tình huống mà các nhân vật điều khiển sẽ không thể nhìn thấy được.

```cat -v unicode.txt```

Mặc dù vậy, rất thường xuyên, để sử dụng tương tác, bạn nên sử dụng một máy nhắn tin tương tác như `less` hoặc `more` . ( `less` là xa mạnh hơn nhiều hơn và nên sử dụng `less` thường xuyên hơn `more` .)

```less file.txt```

Để chuyển nội dung của tệp làm đầu vào cho một lệnh. Một cách tiếp cận thường được coi là tốt hơn (UUOC ) là sử dụngchuyển hướng.

```tr A-Z a-z <file.txt # as an alternative to cat file.txt | tr A-Z a-z```

Trong trường hợp nhu cầu nội dung được liệt kê ngược từ kết thúc lệnh `tac` có thể được sử dụng:

```tac file.txt```

Nếu bạn muốn in nội dung có số dòng, hãy sử dụng -n với `cat` :

```cat -n file.txt```

Để hiển thị nội dung của tệp ở dạng byte-by-byte hoàn toàn rõ ràng, kết xuất hex là tiêu chuẩndung dịch. Điều này tốt cho các đoạn trích rất ngắn của tệp, chẳng hạn như khi bạn không biết mã hóa chính xác. Cáctiện ích kết xuất hex tiêu chuẩn là od -cH , mặc dù biểu diễn hơi cồng kềnh; thay thế thông thườngbao gồm xxd và hexdump.



## Section 5.3: Write to a file (Ghi vào tệp)


```cat >file```

Nó sẽ cho phép bạn viết văn bản trên thiết bị đầu cuối sẽ được lưu trong một tệp có tên tệp.

```cat >>file```

sẽ làm tương tự, ngoại trừ nó sẽ nối văn bản vào cuối tệp.
N.B:  Ctrl + D để kết thúc việc viết văn bản trên thiết bị đầu cuối (Linux). 
Một tài liệu ở đây có thể được sử dụng để viết nội dung của tệp vào dòng lệnh hoặc tập lệnh:

```
cat <<END >file
Hello, World.
END
```


Mã thông báo sau << biểu tượng chuyển hướng là một chuỗi tùy ý cần phải diễn ra một mình trên một dòng (không có đầuhoặc khoảng trắng ở cuối) để biểu thị phần cuối của tài liệu tại đây. Bạn có thể thêm trích dẫn để ngăn trình baothực hiện thay thế lệnh và nội suy biến:
```
cat <<'fnord'
Nothing in `here` will be $changed
fnord
```

(Không có dấu ngoặc kép, ở đây sẽ được thực thi dưới dạng lệnh và $ change sẽ được thay thế bằng giá trị củabiến đã thay đổi - hoặc không có gì, nếu nó chưa được xác định.)

## Section 5.4: Show non printable characters (Hiển thị các ký tự không in được)

Điều này rất hữu ích để xem liệu có bất kỳ ký tự không in được hoặc không phải ký tự ASCII hay không.Ví dụ: Nếu bạn đã sao chép mã từ web, bạn có thể có các dấu ngoặc kép như " thay vì tiêu chuẩn ".

```
$ cat -v file.txt
$ cat -vE file.txt # Useful in detecting trailing spaces.
```

e.g.

```
$ echo '” ' | cat -vE # echo | will be replaced by actual file.
M-bM-^@M-^] $
```
Bạn cũng có thể muốn sử dụng cat -A (A for All) tương đương với cat -vET . Nó sẽ hiển thị các ký tự TAB (hiển thị dưới dạng ^ I ), các ký tự không in được và cuối mỗi dòng:

```
$ echo '” `' | cat -A
M-bM-^@M-^]^I`$
```

## Section 5.5: Read from standard input (Đọc từ đầu vào chuẩn)

```cat < file.txt```

Đầu ra giống như cat file.txt , nhưng nó đọc nội dung của tệp từ đầu vào chuẩn thay vì trực tiếp từ tập tin.

```printf "first line\nSecond line\n" | cat -n```

Lệnh echo trước | xuất ra hai dòng. Lệnh cat hoạt động trên đầu ra để thêm số dòng.

## Section 5.6: Display line numbers with output (Hiển thị số dòng với đầu ra)

Sử dụng cờ --number để in số dòng trước mỗi dòng. Ngoài ra, -n cũng làm điều tương tự.

```
$ cat --number file
1 line 1
2 line 2
3
4 line 4
5 line 5
```

Để bỏ qua các dòng trống khi đếm dòng, hãy sử dụng --number-nonblank , hoặc đơn giản là -b.

```
$ cat -b file
1 line 1
2 line 2
3 line 4
4 line 5
```

## Section 5.7: Concatenate gzipped files (Nối các tệp đã nén)

Các tệp được nén bởi gzip có thể được nối trực tiếp thành các tệp gzip lớn hơn.

```cat file1.gz file2.gz file3.gz > combined.gz```

Đây là một thuộc tính của gzip kém hiệu quả hơn việc nối các tệp đầu vào và giải nén kết quả:

```cat file1 file2 file3 | gzip > combined.gz```

Một minh chứng đầy đủ:
```
echo 'Hello world!' > hello.txt
echo 'Howdy world!' > howdy.txt
gzip hello.txt
gzip howdy.txt
cat hello.txt.gz howdy.txt.gz > greetings.txt.gz
gunzip greetings.txt.gz
cat greetings.txt
```

Kết quả:
```
Hello world!
Howdy world!
```

Lưu ý rằng `greetings.txt.gz` là một tệp duy nhất và được giải nén dưới dạng tệp đơn ``greeting.txt`` . Ngược lại điều này với  `tar -czf hello.txt howdy.txt > greetings.tar.gz` , mà giữ các tập tin riêng rẽ bên trong tarball.
