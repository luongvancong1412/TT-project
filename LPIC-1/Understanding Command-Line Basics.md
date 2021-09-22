# Understatnding Command-Line Basics
## Discussing Distributions
Các bản phân phối( còn gọi là distro).
Tốt nhất nên dùng các bản phân phối đã được sử dụng trong cuốn sách bao gồm:
- CentOS 7 Everything
- Ubuntu Desktop 18-04 LTS
- Fedora 29 Workstation
- and openSUSE 15 Leap distros.

## Reaching a Shell
Nếu bạnsử dụng giao diện người dùng đồ họa (GUI) của bản phân phối Linux, bạn có thể truy cập command bằng cách:
- Trên Ubuntu Workstation, nhấn Ctrl + Alt + T.
- Trên CentOS 7 Everything và Máy trạm Fedora 29, hãy nhấp vào Hoạt động tùy chọn menu, nhập ```term``` vào thanh tìm kiếm và chọn biểu tượng ```terminal icon```.
Trên  openSUSE 15 Leap, hãy nhấp vào biểu tượng ```Application Menu icon``` bên trái của màn hình , nhập ```term``` vào thanh tìm kiếm và chọn một trong các biểu tượng ```terminal icons```.

## Exploring Your Linux Shell Options
Một số bản phân phối khác:

- Bash
- Dash
- KornShell
- tcsh
- Z shell
Listing 1.1: Show to which shell ```/bin/sh``` on Centos

```
#readlink /bin/sh
bash
```
Listing 1.2: show to which shell ```/bin/sh``` Ubuntu

```
$ readlink /bin/sh
dash
```
Listing 1.3: Hiển thị đường dẫn shell và version trên Centos

```
[root@localhost ~]# echo $SHELL
/bin/bash
[root@localhost ~]# echo $BASH_VERSION
4.2.46(2)-release
[root@localhost ~]#
```
Listing 1.4:Hiển thị đường dẫn shell và version trên Ubuntu

```
$ uname
Linux
$
$ uname -r
4.15.0-46-generic
$
$ uname -a
Linux Ubuntu1804 4.15.0-46-generic #49-Ubuntu SMP Wed Feb 6
09:33:07 UTC 2019 x86_64 x86_64 x86_64 GNU/Linux
```
## Using a Shell
Sử dụng lệnh echo cho các tính năng hữu ích của shell

## Navigating the Directory Structure
Sử dụng lênh cd để di chuyển giữa các thư mục và lệnh pwd để xem vị trí thư mục hiện tại

## Using Environment Variables
Các biến môi trường theo dõi thông tin hệ thống, chẳng hạn như: tên người dùng đã đăng nhập vào shell, thư mục mặc định của người dùng ...

Vì Hello.sh nằm trong thư mục không có trong PATH nên không thể trực tiếp chạy Hello.sh

```
root@ubuntu18:~# Hello.sh
Hello.sh: command not found
```
mà chỉ ra đường dẫn đến file đó:

```
root@ubuntu18:~# /root/hung/Hello.sh
Hello world
```
## Getting Help
Sử dụng lệnh man để xem trợ giúp về các tùy chọn hoặc cú pháp của lệnh
Cú pháp: ```man [option] [command]```

Sử dụng lệnh ```history``` để xem lại các lệnh thực hiện gần đây:
```
  992   ip a
  993   vi /etc/sysconfig/network-scripts/ifcfg-ens33
  994   systemctl restart network
  995   systemctl status network.service
  996   journalctl -xe
  997   vi /etc/sysconfig/network-scripts/ifcfg-ens33
  998   reboot
  999   readlink /bin/sh
 1000   echo $SHELL
 1001  echo $BASH_VERSION
 1002  history
```
Để quay lại 1 lệnh mới sử dụng trước

```
[root@localhost ~]# !999
readlink /bin/sh
bash
```
