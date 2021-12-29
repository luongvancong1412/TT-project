# Chapter 42: File Transfer using scp - Truyền tệp bằng scp


## 42.1: scp chuyển tệp - scp transferring file

Để chuyển tệp một cách an toàn sang máy khác - hãy nhập:

```
scp file1.txt tom@server2:$HOME
```

Ví dụ này trình bày việc chuyển file1.txt từ máy chủ của chúng tôi đến thư mục chính của user tom của server2 .

## 42.2: scp chuyển nhiều tệp - scp transferring multiple files

scp cũng có thể được sử dụng để chuyển nhiều tệp từ máy chủ này sang máy chủ khác. Dưới đây là ví dụ về chuyển tất cả các tệptừ thư mục my_folder có đuôi .txt đến server2 . Trong ví dụ dưới đây, tất cả các tệp sẽ được chuyển đến người dùng tomthư mục chính.

```
scp /my_folder/*.txt tom@server2:$HOME
```

## 42.3: Tải xuống tệp bằng scp - Downloading file using scp

Để tải tệp từ máy chủ từ xa xuống máy cục bộ - hãy nhập:

```
scp tom@server2:$HOME/file.txt /local/machine/path/
```

Ví dụ này cho thấy cách tải xuống tệp có tên file.txt từ thư mục chính của user tom vào cục bộ của chúng tôithư mục hiện tại của máy.