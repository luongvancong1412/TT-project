# Tìm hiểu về Logical Volume Manager

- [Tìm hiểu về Logical Volume Manager](#tìm-hiểu-về-logical-volume-manager)
  - [1. Logical Volume Manager](#1-logical-volume-manager)
  - [2. Mục đích sử dụng](#2-mục-đích-sử-dụng)
  - [3.Ưu nhược điểm](#3ưu-nhược-điểm)
  - [4.Mô hình LVM](#4mô-hình-lvm)
  - [5.Tạo LVM](#5tạo-lvm)
    - [5.1 Thêm ổ cứng ảo](#51-thêm-ổ-cứng-ảo)
    - [5.2 Tạo Partition](#52-tạo-partition)
    - [5.3 Tạo Physical Volume](#53-tạo-physical-volume)
    - [5.4 Tạo Volume Group](#54-tạo-volume-group)
    - [5.5 Tạo Logical Volume](#55-tạo-logical-volume)
    - [5.6 Định dạng Logical Volume](#56-định-dạng-logical-volume)
    - [5.7 Mount và sử dụng](#57-mount-và-sử-dụng)
  - [Các thao tác trên LVM](#các-thao-tác-trên-lvm)
- [Tài liệu tham khảo](#tài-liệu-tham-khảo)

## 1. Logical Volume Manager
LVM (Logical Volume Manager) là một công cụ quản lý các ổ đĩa được cài đặt trên máy tính cho hệ điều hành linux.


Một số khái niệm liên quan:
- Physical volume: là một đĩa cứng vật lý hoặc là partition
- Volume Group: là một nhóm các physical volume ( ổ đĩa ảo )
- Logical Volume: là các phân vùng ảo của ổ đĩa ảo

Một số lệnh cần thiết:

- Lệnh fdisk : Dùng để quản lý việc phân vùng trong ổ cứng. Là một công cụ hữu dụng tron linux tìm hiểu thêm FDISK
- Lệnh mount : Dùng để gắn một phân vùng vào thư mục root để có thể sử dụng được nó tìm hiểu thêm về mount
- Lệnh dd : Dùng Sao lưu và hồi phục toàn bộ dữ liệu ổ cứng hoặc một partition và kiểm tra tốc độ đọc của kiểu lưu trữ dữ liệu trong LVM
## 2. Mục đích sử dụng
LVM được sử dụng cho các mục đích sau:

- Tạo các ổ đĩa logic đơn của nhiều ổ đĩa vật lý hoặc toàn bộ đĩa cứng (hơi giống với RAID 0 , nhưng giống với JBOD hơn ), cho phép thay đổi kích thước ổ đĩa động.
- Quản lý các trang trại đĩa cứng lớn bằng cách cho phép bổ sung và thay thế đĩa mà không có thời gian chết hoặc gián đoạn dịch vụ, kết hợp với hoán đổi nóng .
- Trên các hệ thống nhỏ (như máy tính để bàn), thay vì phải ước tính tại thời điểm cài đặt phân vùng có thể cần lớn như thế nào, LVM cho phép dễ dàng thay đổi kích thước hệ thống tệp khi cần thiết.
- Thực hiện sao lưu nhất quán bằng cách chụp nhanh các tập hợp lý.
- Mã hóa nhiều phân vùng vật lý bằng một mật khẩu.

## 3.Ưu nhược điểm
Ưu điểm :

- Không để hệ thống bị gián đoạn hoạt động
- Không làm hỏng dịch vụ
- Có thể tạo ra các vùng dung lượng lớn nhỏ tuỳ ý.


Nhược điểm:

- Các bước thiết lập phức tạp và khó khăn hơn
- Càng gắn nhiều đĩa cứng và thiết lập càng nhiều LVM thì hệ thống khởi động càng lâu.
- Khả năng mất dữ liệu cao khi một trong số các đĩa cứng bị hỏng.
- Windows không thể nhận ra vùng dữ liệu của LVM. Nếu Dual-boot ,- Windows sẽ không thể truy cập dữ liệu trong LVM.
## 4.Mô hình LVM
![](image/mhlvm.png)

Physical Drivers
- Thiết bị lưu trữ dữ liệu, ví dụ như trong linux nó là /dev/sdb,/dev/sdc .

Partitions:
- Partitions là các phân vùng của Hard drives, mỗi Hard drives có 4 partition, trong đó partition bao gồm 2 loại là primary partition và extended partition.
- Primary partition: Phân vùng chính, có thể khởi động , mỗi đĩa cứng có thể có tối đa 4 phân vùng này.
- Extended partition: Phân vùng mở rộng

Physical Volumes:
- Là những thành phần cơ bản được sử dụng bởi LVM dể xây dựng lên các tầng cao hơn . Một Physical Volume không thể mở rộng ra ngoài phạm vi một ổ đĩa. Chúng ta có thể kết hợp nhiều Physical Volume thành Volume Groups

Volume Group
- Nhiều Physical Volume trên những ổ đĩa khác nhau được kết hợp lại thành một Volume Group
- Volume Group được sử dụng để tạo ra các Logical Volume, trong đó người dùng có thể tạo, thay đổi kích thước, lưu trữ, gỡ bỏ và sử dụng.

Logical Volumes:
- Có chức năng là các phân vùng trong ổ cứng vật lý , có thể thu hồi hoặc thêm dung lượng một cách dễ dàng . Là thành phần chính để người dùng và các phần mềm tương tác .

File Systems

- Tổ chức và kiểm soát các tập tin
- Được lưu trữ trên ổ đĩa cho phép truy cập nhanh chóng và an toàn
- Sắp xếp dữ liệu trên đĩa cứng máy tính
- Quản lý vị trí vật lý của mọi thành phần dữ liệu

## 5.Tạo LVM
Chuẩn bị
    Máy ảo Centos 7 trên VMWare

### 5.1 Thêm ổ cứng ảo


![](image/b1.png)

![](image/b2.png)

![](image/b3.png)

![](image/b4.png)

![](image/b5.png)

![](image/b6.png)

![](image/b7.png)

![](image/b9.png)

Kiểm tra ổ đĩa trên Linux bằng lệnh: `lsblk`

Kết quả:
```
[root@localhost ~]# lsblk
NAME            MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
sda               8:0    0   40G  0 disk
├─sda1            8:1    0    1G  0 part /boot
└─sda2            8:2    0   39G  0 part
  ├─centos-root 253:0    0   37G  0 lvm  /
  └─centos-swap 253:1    0    2G  0 lvm  [SWAP]
sdb               8:16   0    3G  0 disk
sdc               8:32   0    3G  0 disk
sdd               8:48   0    3G  0 disk
sr0              11:0    1 1024M  0 rom
```

Ảnh minh hoạ:
![](image/odia.png)

### 5.2 Tạo Partition
– Tạo các partition cho các ổ mới , bắt đầu từ sdb với lệnh :
fdisk /dev/sdb

![](image/sdb.png)

Trong đó bạn chọn n để bắt đầu tạo partition
Bạn chọn p để tạo partition primary
Bạn chọn 1 để tạo partition primary 1
Tại First sector (2048-20971519, default 2048) bạn để mặc định
Tại Last sector, +sectors or +size{K,M,G} (2048-20971519, default 20971519) bạn chọn +1G để partition bạn tạo ra có dung lượng 1 G
Bạn chọn w để lưu lại và thoát.

Tiếp theo bạn thay đổi định dạng của partition vừa mới tạo thành LVM

![](image/doi.png)

Chọn t để thay đổi định dạng partition
Chọn 8e để đổi thành LVM

Tương tự, bạn tạo thêm các partition primary từ sdb và tạo các partition primary từ sdc bằng lệnh fdisk /dev/sdc

![](image/htb1.png)

###  5.3 Tạo Physical Volume

Tạo các Physical Volume là /dev/sdb1 và /dev/sdc1 bằng các lệnh sau:

```
# pvcreate /dev/sdb1
```
```
# pvcreate /dev/sdc1
```

![](image/pv.png)

Kiểm tra bằng lệnh pvs hoặc pvdisplay xem các physical volume đã được tạo chưa :

![](image/pvs.png)

### 5.4 Tạo Volume Group

Tiếp theo, nhóm các Physical Volume thành 1 Volume Group bằng cách sử dụng câu lệnh sau:

`# vgcreate vg-cong1 /dev/sdb1 /dev/sdc1`

Trong đó vg-cong1 là tên của Volume Group

Có thể sử dụng câu lệnh sau để kiểm tra lại các Volume Group đã tạo
```
# vgs
```
```
# vgdisplay
```

![](image/vg.png)

Kiểm tra:

```
[root@localhost ~]# vgdisplay
  --- Volume group ---
  VG Name               centos
  System ID
  Format                lvm2
  Metadata Areas        1
  Metadata Sequence No  3
  VG Access             read/write
  VG Status             resizable
  MAX LV                0
  Cur LV                2
  Open LV               2
  Max PV                0
  Cur PV                1
  Act PV                1
  VG Size               <39.00 GiB
  PE Size               4.00 MiB
  Total PE              9983
  Alloc PE / Size       9982 / 38.99 GiB
  Free  PE / Size       1 / 4.00 MiB
  VG UUID               5EycWR-ubHY-VMS8-NvIv-IGSC-7M6E-gvxPop

  --- Volume group ---
  VG Name               vg-cong1
  System ID
  Format                lvm2
  Metadata Areas        2
  Metadata Sequence No  1
  VG Access             read/write
  VG Status             resizable
  MAX LV                0
  Cur LV                0
  Open LV               0
  Max PV                0
  Cur PV                2
  Act PV                2
  VG Size               1.99 GiB
  PE Size               4.00 MiB
  Total PE              510
  Alloc PE / Size       0 / 0
  Free  PE / Size       510 / 1.99 GiB
  VG UUID               X2XzVq-jRof-fFCD-5S4A-veiE-9RJy-dt77BW
```
Hoặc
```
[root@localhost ~]# vgs
  VG       #PV #LV #SN Attr   VSize   VFree
  centos     1   2   0 wz--n- <39.00g 4.00m
  vg-cong1   2   0   0 wz--n-   1.99g 1.99g
```
### 5.5 Tạo Logical Volume
Từ một Volume Group, Có thể tạo ra các Logical Volume bằng cách sử dụng lệnh sau:

```
# lvcreate -L 1G -n lv-cong1 vg-cong1
```

-L: Chỉ ra dung lượng của logical volume

-n: Chỉ ra tên của logical volume

Trong đó lv-cong1 là tên Logical Volume, vg-cong1 là Volume Group vừa tạo ở bước trước

Lưu ý là chúng ta có thể tạo nhiều Logical Volume từ 1 Volume Group

Có thể sử dụng câu lệnh sau để kiểm tra lại các Logical Volume đã tạo
```
# lvs
```
```
# lvdisplay
```

Minh hoạ:

```
[root@localhost ~]# lvcreate -L 1G -n lv-cong1 vg-cong1
  Logical volume "lv-cong1" created.
[root@localhost ~]# lvs
  LV       VG       Attr       LSize  Pool Origin Data%  Meta%  Move Log Cpy%Sync Convert
  root     centos   -wi-ao---- 36.99g
  swap     centos   -wi-ao----  2.00g
  lv-cong1 vg-cong1 -wi-a-----  1.00g
```
![](image/lvs.png)

### 5.6 Định dạng Logical Volume

Để format các Logical Volume thành các định dạng như ext2, ext3, ext4, ta có thể làm như sau:

```
# mkfs -t ext3 /dev/vg-cong1/lv-cong1
```


Minh hoạ:

```
[root@localhost ~]# mkfs -t ext3 /dev/vg-cong1/lv-cong1
mke2fs 1.42.9 (28-Dec-2013)
Filesystem label=
OS type: Linux
Block size=4096 (log=2)
Fragment size=4096 (log=2)
Stride=0 blocks, Stripe width=0 blocks
65536 inodes, 262144 blocks
13107 blocks (5.00%) reserved for the super user
First data block=0
Maximum filesystem blocks=268435456
8 block groups
32768 blocks per group, 32768 fragments per group
8192 inodes per group
Superblock backups stored on blocks:
        32768, 98304, 163840, 229376

Allocating group tables: done
Writing inode tables: done
Creating journal (8192 blocks): done
Writing superblocks and filesystem accounting information: done
```
![](image/mu.png)

### 5.7 Mount và sử dụng

Tạo ra một thư mục để mount Logical Volume đã tạo vào thư mục đó

```
# mkdir Luutru
```

Tiến hành mount logical volume lv-cong1 vào thư mục Luutru như sau:

```
# mount /dev/vg-cong1/lv-cong1 Luutru
```

Kiểm tra lại dung lượng của thư mục đã được mount:

```
# df -h
```

![](image/mount.png)

## Các thao tác trên LVM


# Tài liệu tham khảo
1. https://www.techwiz.ca/~peters/presentations/lvm/oclug-lvm.pdf
2. https://bachkhoa-aptech.edu.vn/gioi-thieu-ve-logical-volume-manager/279.html