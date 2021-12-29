# Chapter 51: co-processes

## 51.1: Hello World
```
# tạo quy trình co
coproc bash

# gửi một lệnh đến nó (echo a)
echo 'echo Hello World' >&"${COPROC[1]}"

# đọc một dòng từ đầu ra của nó
read line <&"${COPROC[0]}"

# hiển thị dòng
echo "$line"
```

Đầu ra là "Hello World".