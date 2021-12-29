# Chapter 52: Typing variables

## 52.1: Khai báo các biến được gõ yếu

khai báo là một lệnh nội bộ của bash. (sử dụng lệnh nội bộ trợ giúp để hiển thị "manpage"). Nó được sử dụng để hiển thịvà xác định các biến hoặc hiển thị các thân hàm.

Cú pháp:  **declare [options] [name[=value]]...**

```
# tùy chọn được sử dụng để xác định
# một số nguyên
declare -i myInteger
declare -i anotherInt=10
# một mảng có các giá trị
declare -a anArray=( one two three)
# an assoc Array
declare -A assocArray=( [element1]="something" [second]=anotherthing )
# lưu ý rằng bash nhận ra ngữ cảnh chuỗi trong []

# tồn tại một số bổ ngữ
# nội dung viết hoa
declare -u big='this will be uppercase'
# giống nhau cho chữ thường
declare -l small='THIS WILL BE LOWERCASE'

# mảng chỉ đọc
declare -ra constarray=( eternal true and unchangeable )
# xuất số nguyên sang môi trường
declare -xi importantInt=42
```

Bạn cũng có thể sử dụng dấu + để lấy đi thuộc tính đã cho. Hầu hết là vô dụng, chỉ cho sự hoàn chỉnh.
Để hiển thị các biến và / hoặc hàm, cũng có một số tùy chọn
```
# printing definded vars and functions
declare -f
# giới hạn đầu ra chỉ cho các chức năng
declare -F #nếu gỡ lỗi in ra cả số dòng và tên tệp được xác định trong
```