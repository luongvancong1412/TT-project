# head -- displays the first lines of files

## 1.Notes

## 2.Examples
```
head -f file1
```

```
head -n 50 file1
```

## 3.Command Help (man head)

Các tùy chọn sau có thể được sử dụng:

-c , --bytes =[-]NUM in NUM byte đầu tiên của mỗi tệp; với '-' ở đầu , in tất cả trừ NUM byte cuối cùng của mỗi tệp

-n , --lines =[-]NUM in NUM dòng đầu tiên thay vì 10 dòng đầu tiên ; với '-' ở đầu , in tất cả trừ NUM dòng cuối cùng của mỗi tệp

-q , --quiet , --silent     không bao giờ in tiêu đề cho tên tệp

-v , --verbose             luôn in tiêu đề tên tệp

-z , --zero-terminated   dấu phân cách dòng kết thúc bằngzero là NUL, không phải dòng mới

--help  hiển thị trợ giúp này và thoát

--version thông tin phiên bản đầu ra phiên bản và thoát .

NUM có thể có hậu tố cấp số nhân:
b 512
kB 1000
K 1024
MB 1000*1000
M 1024*1024
GB 1000*1000*1000
G 1024*1024*1024
and so on for T, P, E, Z, Y.