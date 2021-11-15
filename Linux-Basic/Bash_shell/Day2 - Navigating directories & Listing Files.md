# Navigating directories – Điều hướng thư mục
## 1.1 Absolute vs relative directories
Absolute vs relative directories – Thư mục tuyệt đối và Thư mục tương đối. 
- Để thay đổi thành một thư mục được chỉ định tuyệt đối, hãy sử dụng toàn bộ tên, bắt đầu bằng dấu gạch chéo /:

```cd /home/username```

- Nếu bạn muốn thay đổi một thư mục gần hiện tại của bạn, bạn có thể chỉ định một vị trí tương đối. Mà hiện tại bạn đang đứng tại `Tailieu` bạn sử dụng bí danh .. để thực hiện di chuyển về thư mục `user3` thay vì phải sử dụng đường dẫn tuyệt đối, ví dụ:

```
[root@localhost Tailieu]# pwd
/home/user3/Tailieu
[root@localhost Tailieu]# cd ..
[root@localhost user3]# pwd
/home/user3
```

Ví dụ, nếu trong thư mục Picture có các thư mục sau:Baitap, Tailieu . Bạn có thể nhập trực tiếp thư mục con thay vì đường dẫn tuyệt đối đến thư mục con.

```
[root@localhost user3]# ls
Baitap  Tailieu
[root@localhost user3]# cd Tailieu
[root@localhost Tailieu]# pwd
/home/user3/Tailieu
```

## 1.2 Thay đổi đến thư sử dụng cuối cùng

```cd -```

```
[root@localhost Tailieu]# cd -
/home/user3
[root@localhost user3]# cd -
/home/user3/Tailieu
[root@localhost Tailieu]# cd -
/home/user3
```

## 1.3 Thay đổi đến thư mục chính.
Biến `$HOME` là biến môi trường biểu thị thư mục của người dùng hiện tại.

```
[root@localhost user3]# echo $HOME
/root
[root@localhost user3]# cd $HOME
[root@localhost ~]# pwd
/root
```

## 1.4 Thay đổi thư mục của script

Có hai loại tệp bash:

- System tool- Các công cụ hệ thống hoạt động từ thư mục làm việc hiện tại
- Project tool công cụ dự án sửa đổi tệp liên quan đến vị trí của chúng trong hệ thống tệp.

Đối với Project tool sẽ hữu ích khi thay đổi thành thư mục nơi script được lưu trữ điều này có thể được thực hiện với lệnh sau:
```cd "$(dirname "$(readlink -f "$0")")"```

Câu lệnh trên thực hiện chạy 3 lệnh:

1. `readlink -f "$0"` xác định đường dẫn đến script hiện tại `($0)`
2. `dirname` chuyển đổi đường dẫn đến script thành đường dẫn đến thư mục của nó
3. `cd` Thay đổi thư mục làm việc hiện tại thành thư mục mà nó nhận được từ `dirname`

# Listing Files
## 2.1 Liệt kê file ở định dạng danh sách dài

Tùy chọn `-l` của lệnh `ls` hiển thị nội dung của thư mục cụ thể ở định dạng danh sách dài. Nếu không có đối số của thư mục chỉ định chỉ nó sẽ hiển thị nội dung của thư mục hiện tại.

```
[root@localhost user3]# ls -l
total 0
drwxr-xr-x. 2 root root 38 Nov  4 20:00 Baitap
drwxr-xr-x. 2 root root  6 Nov  4 19:25 Tailieu
[root@localhost user3]# ls -l /home/user3/Baitap
total 0
-rw-r--r--. 1 root root 0 Nov  4 20:00 bai1.txt
-rw-r--r--. 1 root root 0 Nov  4 20:00 bai2.txt
```

Dòng đầu tiên total cho biết tổng kích thước của tất cả các tệp trong thư mục được liệu kê. Sau đó hiển thị 8 cột thông tin:

|Số cột|Ví dụ|Mô tả|
|---|---|---|
|1.1|d | Loại của tệp|
|1.2|rw-r--r--|Chuỗi biểu thị quyền hạn cho user group own(permission)|
|2|1 or 2|Các liên kết|
|3|root| Tên chủ sở hữu|
|4|root| Tên nhóm sở hữu|
|5|38| Kích cỡ của tệp với đơn vị bytes|
|6| Nov 4 20:00| Thời gian sửa cuối cùng|
|7|Baitap| Tên thư mục or file|

**Loại của tệp**
|Ký tự| Loại tệp|
|---|---|
|-|Tệp thông thường|
|b|Chặn các tệp đặc biệt|
|c|Tệp ký tự đặc biệt|
|C|Tệp hiệu xuất cao
|d|Thư mục
|D|Door(tệp đặc biệt chỉ có trong Solaris 2.5+)
|l|Liên kết tượng trưng- Symbolic link
|M|Off-line (đã được chuyển đi)
|n|Tệp đặc biệt của mạng(HP-UX)
|p|FIFO(name pipe)
|P|port (tệp đặc biệt chỉ có trong Solaris 10+)
|S|Socket
|?|Một số loại tệp khác

## 2.2 Liệt kê ra 10 tệp được sửa đổi gần nhất
Câu lệnh dưới đây sẽ liệt kê 10 tệp được sửa đổi gần nhất trong thư mục hiện tại, sử dụng `long listing format`(định dạng danh sách dài) `-l` và `sort by time`(tìm kiếm theo thời gian) `-t`.

```ls -lt |head```

## 2.3 Liệt kê tất cả các tệp bao gồm các tệp Dotfiles(file ẩn)

Dotfiles là một file bắt đầu bằng dấu chấm(.). Khi thực hiện ls thì sẽ không được hiển thị trừ khi được yêu cầu

Tùy chọn -a hoặc –all sẽ liệt kê tất cả các tệp bao gồm các tệp dotfiles.

```
[root@localhost user3]# ls
Baitap  Tailieu
[root@localhost user3]# ls -a
.  ..  Baitap  .bash_history  .bash_logout  .bash_profile  .bashrc  Tailieu
```

Tùy chọn -A hoặc –almost-all sẽ liệt kê tất cả các loại tệp, bao gồm các tệp Dotfiles, nhưng không liệt kê implied (.) và (..).

```
[root@localhost user3]# ls -A
Baitap  .bash_history  .bash_logout  .bash_profile  .bashrc  Tailieu
```

## 2.4 Liệt kê ra các file có định dạng giống như cây thư mục
Lệnh tree liệt kê nội dung của một thư mục được chỉ định ở định dạng cây.

```
[root@localhost ~]# tree
.
├── anaconda-ks.cfg
├── baitap
│   └── bai1
├── bao_cao
├── hello.sh
├── jdk-8u291-windows-x64.exe
├── lab
│   ├── thumuc1
│   ├── vidu1.txt
│   ├── vidu2.txt
│   └── vidu3.txt
├── nflog
├── nmap-7.91-1.x86_64.rpm
├── ptftp.pcap
├── pt.pcap
├── userinput.sh
├── VD1
│   ├── abc
│   ├── bin.rar
│   └── text.txt
└── vi.txt

5 directories, 30 files
```

Để cài đặt và sử dụng lệnh cho Centos7: sudo yum install tree hoặc cho Ubuntu: apt install tree

## 2.5 Liệt kê danh sách các tệp được sắp xếp theo kích thước
Tùy chọn -S của lệnh ls sắp xếp các tẹp theo thứ tự giảm dần về kích thước:

```
[root@localhost ~]# ls -lS
total 180248
-rw-r--r--. 1 root    root    176876296 Jul 20 15:40 jdk-8u291-windows-x64.exe
-rw-rw-rw-. 1 root    root      7469944 Jul 20 15:03 nmap-7.91-1.x86_64.rpm
-rw-r--r--. 1 tcpdump tcpdump     48974 Jul  2 17:40 capture.pcap
-rw-r--r--. 1 tcpdump tcpdump     46564 Aug 21 22:28 dhcppt.pcap
-rw-r--r--. 1 root    root        42908 Jul 20 16:35 pt.pcap
-rw-r--r--. 1 tcpdump tcpdump      4261 Sep  4 16:17 ptftp.pcap
-rw-r--r--. 1 root    root         3935 Jul 20 21:05 bao_cao
-rw-r--r--. 1 tcpdump tcpdump      3608 Aug 19 16:12 dhcp2.pcap
-rw-r--r--. 1 tcpdump tcpdump      3608 Aug 19 15:59 dhcp.pcap
-rw-r--r--. 1 tcpdump tcpdump      3604 Aug 21 20:58 dhcpcap.pcap
-rw-r--r--. 1 tcpdump tcpdump      2888 Aug 19 16:09 dhcp1.pcap
-rw-r--r--. 1 tcpdump tcpdump      2824 Jul  2 17:44 capture.txt
-rw-r--r--. 1 tcpdump tcpdump      2368 Sep  1 19:13 congftp.pcap
-rw-r--r--. 1 root    root         2104 Jul 20 21:05 bao-cap
-rw-r--r--. 1 tcpdump tcpdump      1295 Sep  1 19:25 congftp2.pcap
-rw-------. 1 root    root         1293 Apr  5  2021 anaconda-ks.cfg
-rw-r--r--. 1 root    root         1187 Jul 20 21:05 bao-cao
-rw-r--r--. 1 tcpdump tcpdump      1170 Jul  2 17:40 capture
-rwxr-xr-x. 1 root    root           83 Oct 21 15:03 userinput.sh
-rwxr-xr-x. 1 root    root           79 Oct 21 16:05 hello.sh
drwxr-xr-x. 3 root    root           72 Jun 16 02:47 lab
drwxrwxrwx. 3 root    root           48 Jul 20 14:43 VD1
-rw-r--r--. 1 tcpdump tcpdump        24 Jul  2 21:35 conf.txt
-rw-r--r--. 1 tcpdump tcpdump        24 Sep  1 19:15 congftp1.pcap
-rw-r--r--. 1 tcpdump tcpdump        24 Jul  2 17:05 nflog
drwxr-xr-x. 2 root    root           18 May 30 19:47 baitap
-rw-r--r--. 1 root    root            4 Sep 27 03:09 vi.txt
```

Muốn sắp xếp theo thứ tự tăng dần sử dụng ls -lSr