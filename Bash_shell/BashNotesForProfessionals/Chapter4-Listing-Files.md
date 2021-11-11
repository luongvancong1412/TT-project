# Chapter 4: Listing Files (Danh sách tệp)
|Option|Mô tả|
|---|---|
|a , --all|Liệt kê tất cả các mục nhập bao gồm những mục bắt đầu bằng dấu chấm|
|-A ,|Liệt kê tất cả các mục không bao gồm . và ..|
|-c|Sắp xếp tệp theo thời gian thay đổi
|-d , --directory|Liệt kê các mục trong thư mục
|-h ,| Hiển thị kích thước ở định dạng con người có thể đọc được (tức là K , M )
|-H|Tương tự như trên chỉ với lũy thừa 1000 thay vì 1024
|-l|Hiển thị nội dung ở định dạng danh sách dài
|-o|Định dạng danh sách dài không có thông tin nhóm
|-r ,|Hiển thị nội dung theo thứ tự ngược lại
|-s ,Kích thước in của từng tệp theo khối
|-S|Sắp xếp theo kích thước tệp
|--sort = WORD|Sắp xếp nội dung theo một từ. (tức là kích thước, phiên bản, trạng thái)
|-t|Sắp xếp theo thời gian sửa đổi
|-u|Sắp xếp theo thời gian truy cập gần đây nhất
|-v|Sắp xếp theo phiên bản
|-1|Liệt kê một tệp trên mỗi dòng|

## Phần 4.1: List Files in a Long Listing Format (Liệt kê các tệp ở định dạng danh sách dài)
Các `ls` lệnh của `-l` tùy chọn in nội dung của một thư mục cụ thể trong một định dạng danh sách dài. Nếu không có thư mục làđược chỉ định sau đó, theo mặc định, nội dung của thư mục hiện tại được liệt kê.

`ls -l /etc`

Ex Output:
```
[root@localhost ~]# ls -l /etc
total 1256
drwxr-xr-x.  2 root root   4096 Oct  8 07:50 alternatives
-rw-------.  1 root root    541 Aug  9  2019 anacrontab
...
```

|Số cột|Ví dụ|Mô tả|
|---|---|---|
1.1|d|Loại tệp (xem bảng bên dưới)|
1,2|rwxr-xr-x|Chuỗi quyền
2|2|Số lượng liên kết cứng
3|root|Tên chủ sở hữu
4|root|Nhóm chủ sở hữu
5|4096|Kích thước tệp tính bằng byte
6|Oct  8 07:50| Thời gian sửa đổi
7|alternatives|Tên tệp|

**Loại tệp**
Loại tệp có thể là một trong bất kỳ ký tự nào sau đây.

|Ký tự|Loại File|
|---|---|
|-|Tệp thông thường
b|Chặn tệp đặc biệt
c|Kí tự đặc biệt tệp
C|Tệp hiệu suất cao ("dữ liệu liền kề")
d|Thư mục|
D|Cửa (tệp IPC đặc biệt chỉ trong Solaris 2.5+)
l|Liên kết tượng trưng
M|Tệp ngoại tuyến ("đã di chuyển") (Cray DMF)
n|Tệp đặc biệt mạng (HP-UX)
p|FIFO (đường ống được đặt tên)
P|Cổng (tệp hệ thống đặc biệt chỉ trong Solaris 10+)
s| Socket
?|Một số loại tệp khác.

## Phần 4.2: Liệt kê mười tệp được sửa đổi gần đây nhất

Phần sau sẽ liệt kê tối đa mười tệp được sửa đổi gần đây nhất trong thư mục hiện tại, sử dụng một danh sách dàiđịnh dạng ( -l ) và sắp xếp theo thời gian ( -t ).

`ls -lt |head`

## Phần 4.3: Liệt kê tất cả các tệp bao gồm các tệp Dotfiles
Một dotfile là một tập tin có tên bắt đầu với một `.` . 
Chúng thường được ẩn bởi ls và không được liệt kê trừ khi được yêu cầu.

```
[root@localhost ~]# ls
anaconda-ks.cfg  capture        congftp2.pcap  dhcp.pcap                  nflog                   VD1
baitap           capture.pcap   congftp.pcap   dhcppt.pcap                nmap-7.91-1.x86_64.rpm  vi.txt
bao_cao          capture.txt    dhcp1.pcap     hello.sh                   ptftp.pcap
bao-cao          conf.txt       dhcp2.pcap     jdk-8u291-windows-x64.exe  pt.pcap
bao-cap          congftp1.pcap  dhcpcap.pcap   lab                        userinput.sh
```

Tuỳ chọn -a hoặc -all: liệt kê tất cả các file
```
[root@localhost ~]# ls -a
.                bao-cap        capture.txt    dhcp2.pcap                 .lesshst                .ssh
..               .bash_history  conf.txt       dhcpcap.pcap               .mysql_history          .tcshrc
.an              .bash_logout   congftp1.pcap  dhcp.pcap                  nflog                   userinput.sh
anaconda-ks.cfg  .bash_profile  congftp2.pcap  dhcppt.pcap                nmap-7.91-1.x86_64.rpm  VD1
baitap           .bashrc        congftp.pcap   hello.sh                   .pki                    vi.txt
bao_cao          capture        .cshrc         jdk-8u291-windows-x64.exe  ptftp.pcap              .vi.txt.swp
bao-cao          capture.pcap   dhcp1.pcap     lab                        pt.pcap
```

Các -A hoặc --almost-tất cả các tùy chọn sẽ liệt kê tất cả các file, bao gồm dotfiles, nhưng không danh sách ngụ ý `.` và `..` . 
Lưu ý:
- `.` Làthư mục hiện tại
- `..` là thư mục mẹ.

```
[root@localhost ~]# ls -A
.an              .bash_history  capture.txt    dhcp1.pcap    jdk-8u291-windows-x64.exe  .pki          VD1
anaconda-ks.cfg  .bash_logout   conf.txt       dhcp2.pcap    lab                        ptftp.pcap    vi.txt
baitap           .bash_profile  congftp1.pcap  dhcpcap.pcap  .lesshst                   pt.pcap       .vi.txt.swp
bao_cao          .bashrc        congftp2.pcap  dhcp.pcap     .mysql_history             .ssh
bao-cao          capture        congftp.pcap   dhcppt.pcap   nflog                      .tcshrc
bao-cap          capture.pcap   .cshrc         hello.sh      nmap-7.91-1.x86_64.rpm     userinput.sh
```

## Phần 4.4: Liệt kê các tệp mà không sử dụng `ls`
Sử dụng phần mở rộng tên tệp của trình bao Bash và khả năng mở rộng dấu ngoặc nhọn để lấy tên tệp:

```
# hiển thị các tệp và thư mục có trong thư mục hiện tại
printf "% s \ n " *
# chỉ hiển thị các thư mục trong thư mục hiện tại
printf "% s \ n " * /
# chỉ hiển thị (một số) tệp hình ảnh
printf "% s \ n " * . { gif, jpg, png }
```

Để nắm bắt danh sách các tệp thành một biến để xử lý, thông thường bạn nên sử dụng mảng bash :

```
file = ( * )
# lặp lại chúng
for file in "${files[@]}"; do
    echo "$file"
done
```
## Phần 4.5: Liệt kê các tập tin
Lệnh ls liệt kê nội dung của một thư mục được chỉ định, không bao gồm dotfiles. Nếu không có thư mục nào được chỉ định thì, bằng cáchmặc định, nội dung của thư mục hiện tại được liệt kê.
Các tệp trong danh sách được sắp xếp theo thứ tự bảng chữ cái, theo mặc định và được căn chỉnh theo cột nếu chúng không nằm trên một dòng.

```
[root@localhost ~]# ls
anaconda-ks.cfg  capture        congftp2.pcap  dhcp.pcap                  nflog                   VD1
baitap           capture.pcap   congftp.pcap   dhcppt.pcap                nmap-7.91-1.x86_64.rpm  vi.txt
bao_cao          capture.txt    dhcp1.pcap     hello.sh                   ptftp.pcap
bao-cao          conf.txt       dhcp2.pcap     jdk-8u291-windows-x64.exe  pt.pcap
bao-cap          congftp1.pcap  dhcpcap.pcap   lab                        userinput.sh
```

## Phần 4.6: Liệt kê các tệp ở định dạng giống cây
Lệnh `tree` liệt kê nội dung của một thư mục được chỉ định ở định dạng giống như cây. Nếu không có thư mục nào được chỉ định thì,theo mặc định, nội dung của thư mục hiện tại được liệt kê.
Ex:
```
[root@localhost ~]# tree /home
/home
├── abc.sh
├── Baigiang
│   └── giaovien1
├── cong
│   └── vd1.txt
├── congftp
│   ├── cung.txt
│   └── mem.txt
├── ftp
│   ├── test
│   │   └── vidu.txt
│   └── user1
├── giaovien
├── giaovien1
├── giaovien2
├── hello.sh
├── mem.txt
├── sinhvien
├── sinhvien1
├── sinhvien2
├── Tailieu
├── Tailieusinhvien
├── Thuchanhsinhvien
├── user3
│   ├── Baitap
│   │   ├── bai1.txt
│   │   └── bai2.txt
│   └── Tailieu
└── vd.txt

19 directories, 10 files
```

Sử dụng tùy chọn -L của lệnh tree để giới hạn độ sâu hiển thị và tùy chọn -d để chỉ liệt kê các thư mục.
Ex:
```
[root@localhost ~]# tree -L 1 -d /home
/home
├── Baigiang
├── cong
├── congftp
├── ftp
├── giaovien
├── giaovien1
├── giaovien2
├── sinhvien
├── sinhvien1
├── sinhvien2
├── Tailieu
├── Tailieusinhvien
├── Thuchanhsinhvien
└── user3

14 directories
```

## Phần 4.7: Liệt kê các tệp được sắp xếp theo kích thước
Các ls lệnh của -S tùy chọn sắp xếp các file theo thứ tự giảm dần kích thước tập tin.

Ex:
```
$ ls -l -S ./Fruits
total 444
-rw-rw-rw- 1 root root 295303 Jul 28 19:19 apples.jpg
-rw-rw-rw- 1 root root 102283 Jul 28 19:19 kiwis.jpg
-rw-rw-rw- 1 root root 50197 Jul 28 19:19 bananas.jpg
```

Khi được sử dụng với tùy chọn -r , thứ tự sắp xếp được đảo ngược.

```
$ ls -l -S -r /Fruits
total 444
-rw-rw-rw- 1 root root 50197 Jul 28 19:19 bananas.jpg
-rw-rw-rw- 1 root root 102283 Jul 28 19:19 kiwis.jpg
-rw-rw-rw- 1 root root 295303 Jul 28 19:19 apples.jpg
```