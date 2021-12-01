# Tìm hiểu Mount


- [Tìm hiểu Mount](#tìm-hiểu-mount)
- [I. Tổng quan](#i-tổng-quan)
  - [1. Khái niệm](#1-khái-niệm)
  - [2. Quá trình mount](#2-quá-trình-mount)
  - [2. Mount point](#2-mount-point)
  - [3. Unmount](#3-unmount)
  - [4.Vfstab](#4vfstab)
  - [5.Cú pháp](#5cú-pháp)
- [II. Lab mount fdisk mkfs](#ii-lab-mount-fdisk-mkfs)
  - [1. Chuẩn bị](#1-chuẩn-bị)
  - [2. Mount](#2-mount)
    - [2.1 Kiểm tra Hard disk](#21-kiểm-tra-hard-disk)
    - [2.1 Tạo partition trên ổ đĩa](#21-tạo-partition-trên-ổ-đĩa)
    - [2.2 Format](#22-format)
    - [2.3 Kết nối](#23-kết-nối)
    - [2.4 umount](#24-umount)
    - [2.5 fstab](#25-fstab)
  - [3. mount iso Centos 7 create local yum](#3-mount-iso-centos-7-create-local-yum)
    - [3.1 chuẩn bị](#31-chuẩn-bị)
    - [3.2 Tiến hành](#32-tiến-hành)
- [III. Thuật ngữ liên quan](#iii-thuật-ngữ-liên-quan)
  - [1. MBR](#1-mbr)
  - [2. GPT](#2-gpt)
  - [3. File System Type](#3-file-system-type)
  - [4. UUID là gì](#4-uuid-là-gì)
- [Tài liệu tham khảo](#tài-liệu-tham-khảo)


# I. Tổng quan
## 1. Khái niệm
- Mount là một quá trình mà trong đó hệ điều hành làm cho các tập tin và thư mục trên một thiết bị lưu trữ (như ổ cứng, CD-ROM hoặc tài nguyên chia sẻ) có thể truy cập được bởi người dùng thông qua hệ thống tệp của máy tính.

## 2. Quá trình mount 
- Quá trình mount bao gồm việc hệ điều hành được truy cập vào phương tiện lưu trữ, công nhận, đọc và xử lý cấu trúc hệ thống tệp cùng với siêu dữ liệu trên nó, sau đó, đăng ký chúng vào thành phần hệ thống tệp ảo (VFS).

Ví dụ: Chúng ta có 1 PC Linux  tuỳ ý, PC này có nhu cầu nâng cấp Hard Disk và đã có "new hard disk". Vấn đề đặt ra là chúng ta làm thế nào để sử dụng được hard disk mới ở trong hệ điều hành.
- Chia Partition: MBR - Master Boot Record (4 primary partition), GPT - GUID Partition Table (128 primary partition)
- Format Partition: Ext4
- Kết nối Partition vào "Folder do admin chỉ định".
=> Quá trình này là quá trình mount

- Vị trí đăng ký trong VFS của phương tiện mới được mount gọi là mount point. 

## 2. Mount point
Đây là điểm mà người dùng có thể truy cập tập tin, thư mục của phương tiện sau khi quá trình mount hoàn thành.

Một điểm mount là một vị trí vật lý trong phân vùng được sử dụng như hệ thống tệp gốc (root filesystem). Có nhiều loại thiết bị lưu trữ, chẳng hạn đĩa từ, từ – quang, quang, và bán dẫn. Tính đến năm 2013, đĩa từ vẫn phổ biến nhất, thông dụng như đĩa cứng hoặc ít thông dụng hơn như đĩa mềm. Trước khi chúng có thể được sử dụng để lưu trữ, tức là có thể đọc ghi thông tin, chúng phải được tổ chức và hệ điều hành phải biết về điều này. Sự tổ chức ấy gọi là hệ thống tệp. Mỗi hệ điều hành có một hệ thống tệp khác nhau cung cấp cho nó siêu dữ liệu để nó biết cách đọc ghi ra sao. Hệ điều hành sẽ đọc những siêu dữ liệu ấy khi phương tiện được mount.

## 3. Unmount
- unmount, trong đó, hệ điều hành huỷ tất cả quyền truy cập tập tin, thư mục của người dùng tại điểm mount, ghi tiếp những dữ liệu người dùng đang trong hàng đợi vào thiết bị, làm mới siêu dữ liệu hệ thống tệp, sau đó, tự huỷ quyền truy cập thiết bị và làm cho thiết bị có thể tháo ra an toàn.

Bình thường, khi tắt máy tính, mỗi thiết bị lưu trữ sẽ trải qua quá trình unmount để đảm bảo rằng tất cả các dữ liệu trong hàng đợi được ghi và để duy trì tính toàn vẹn của cấu trúc hệ thống tệp trên các phương tiện.

**Kết luận**

- mount được sử dụng để gắn kết hệ thống tệp được tìm thấy trên thiết bị với cấu trúc cây lớn ( hệ thống tệp Linux ) có gốc tại ' / '.
- Ngược lại, lệnh umount có thể được sử dụng để tách các thiết bị từ Tree.



## 4.Vfstab

Trong nhiều trường hợp, những hệ thống tệp không phải gốc vẫn cần sẵn sàng ngay khi hệ điều hành khởi động. Tất cả các hệ thống Unix-like đều cung cấp tiện ích để làm điều này. Quản trị viên hệ thống xác định những hệ thống tệp đó trong tập tin cấu hình fstab (vfstab trong Solaris), tập tin này cũng kèm theo các tuỳ chọn và điểm mount. Trong một số trường hợp khác, có những hệ thống tệp nhất định không cần mount khi khởi động dù có cần sử dụng sau đó hay không. Vài tiện ích của các hệ thống Unix-like cho phép mount những hệ thống tệp đã định trước chỉ khi nào cần tới.

```
#vi /etc/fstab
```
- Khi mở file này ra sẽ có rất nhiều dòng, mỗi dòng có 5 cột

Ví dụ:
/dev/sdb1       /data       ext4    default     0       0
Cột 1           Cột 2       Cột 3   Cột 4       Cột 5   Cột 6


- Cột 1: device hoặc partition
- Cột 2: mount point
- Cột 3: Loại file system. Ví dụ: ext2, ext3, ext4,...
- Cột 4: Mount option: auto, no-auto, user, no-user, ro, rw... Option mặc định là "default" bao gồm các tính năng: rw, suid, dev, exec, auto, nouser. (trường hợp nhiều thì dùng dấu phẩy để ngăn cách)
- Cột 5: tính năng DUMP dùng để backup. Mặc định là 0 trong hầu hết các trường hợp (nghĩa là không cần dump, nếu để 1 nó sẽ tạo ra file back up cho mình).
- Cột 6: Sử dụng fsck (filesystem check) để check ổ đĩa có lỗi hay không. Để 0 để không check file system tại phân vùng này.

Thông tin mount của mỗi file hệ thống sẽ lần lược được viết từng dòng vào file fstab. 
Mỗi field của dòng sẽ được cách bởi space, chia nhau ra bởi TAB.
Thêm vào đó, chương trình dùng để đọc file fstab chẳng hạn như fsck(*) mount, unmount thì sẽ đọc từ đầu xuống theo thứ tự từ top nên thứ tự của record (file hệ thống) được ghi lại bên trong fstab thì khá quan trọng.
Note:
- rw: read/write mode
- suid enable SUID
- dev: cho phép sử dụng các ký tự đặc biệt trên file hệ thống
- exec cho phép thực thi trên binary
- auto nếu option -a được chỉ định, ổ cứng sẽ auto mount
- nouser người dùng thông thường (không phải super user) thì không được phép thực thi lệnh mount
- async đối với file hệ thông thì mọi I/O sẽ được tiến hành không đồng bộ
- ro mount với readonly
- nosuid SUID cũng như SGID bị disable
- nodev các ký tự, ký tự đặc biệt, device block, special device…sẽ không sử dụng được
- noexec không được phép trực tiếp execute binary
- noauto nếu option -a được chỉ định, ổ cứng sẽ không auto mount
- user cho phép general user được quyền mount ổ cứng
- users cho phép toàn bộ user đều có thể mount/unmount ổ cứng
## 5.Cú pháp

```mount [OPTION...] DEVICE_NAME DIRECTORY```

# II. Lab mount fdisk mkfs
## 1. Chuẩn bị
- 1 Máy ảo linux: Centos 7 64bit
- Gán thêm 1 Hard disk mới (20GB)
## 2. Mount
- Kiểm tra xem bên trong linux hiện có bao nhiêu hard disk
- Chia nó thành các partition
- Format
- Mount

### 2.1 Kiểm tra Hard disk
```
# cat /proc/partition
cách khác
#ls -l /dev/ | grep -i "sda*"
(-i, --ignore là không phân biệt chữ hoa chữ thường, kiếm xem ổ cứng nào có tên sda và phía sau mặc kệ nó)
or
#fdisk -l (kt có bao nhiêu ổ cứng)
```
###  2.1 Tạo partition trên ổ đĩa
- sử dụng câu lệnh fdisk vào ổ cứng sdb
```
fdisk /dev/sdb
```
- Nhập m để hiển thị ra các menu
- Nhập n để tạo ra new partition
- Nhập p tạo primary partition
- Nhập 1 tạo partition thứ nhất
- default sẽ dùng hết dung lượng hard disk (ở đây +10G)
- Tương tự tạo partition thứ 2 sử dụng hết dung lượng còn lại của hard disk
- Đến đây chương trình của mình cũng chưa tác dụng vào ổ cứng của mình hết, chỉ khi nào bấm "w" (nghĩa là write) thì mới tác dụng.
=> Đến đây chia partition xong.

- Kiểm tra: 
```
#cat /proc/partitions
```
Hiện thời 2 phân vùng sdb1 và sdb2. Tiếp theo sẽ Format nó.

### 2.2 Format 
- Dùng lệnh mkfs (viết tắt của Make file system) để "format" theo định dạng nào đó. Vi dụ: Ext4

```
#mkfs -t ext4 /dev/sdb1
#mkfs -t ext4 /dev/sdb2
```

### 2.3 Kết nối

Giả sử: Folder Data1 kết nối vào sdb1, Folder Data2 kết nối vào sdb2

```
#mkdir /data1
#mkdir /data2
```
- Tạo 2 file data1.txt và data2.txt tương ứng vào /data1 và /data2
```
#cd /data1
#touch data1.txt
#ls -l
#cd /data2
#touch data2.txt
```
Hiện thời 2 file data1.txt và data2.txt đang nằm trong ổ cứng sda chứ không nằm trong sdb.

- Tiến hành mount
```
#cd
#mount -t ext4 /dev/sdb1 /data1
(mount, option -t, loại kết nối(type) ở đây là ext4, nguồn kết nối /dev/sdb1, đích đến mà mình kết nối là /data )
```
- Kiểm thử:
```
#cd /data1
#ls -l
```

Không còn file data1.txt nữa. Bởi vì lúc này folder data1 link sang partition sdb1 rồi mà không phải sda.

Cách khác:
```
#mount
```
để kiểm tra.

### 2.4 umount
- Sử dụng lệnh:
```
#umount /data1
```

- Kiểm tra:

```
#mount
#cd /data1
#ls -l
```

Tương tự mount data2
```
#cd
#mount -t ext4 /dev/sdb2 /data2
#mount
```
- Đứng vào folder data2:
```
#cd /data2
#pwd
/data2
```
- dùng lệnh mount kiểm tra
```
#mount
```
- Umount:
```
# umount /data2
```
Không thể umount được, do đang đứng ở trong data2.

Hiện thời, mount này chỉ có tính chất tạm thời. Nếu reset lại máy thì các kết nối sẽ mất hết.
Nhu cầu: để mount có tính chất cố định, ta sẽ phải ghi vào 1 file: `/etc/fstab`.

### 2.5 fstab
- sử dụng lệnh:

```
#vi /etc/fstab
```
- Khi mở file này ra sẽ có rất nhiều dòng, mỗi dòng có 5 cột

Ví dụ:
/dev/sdb1       /data       ext4    default     0       0
Cột 1           Cột 2       Cột 3   Cột 4       Cột 5   Cột 6


- Cột 1: device hoặc partition
- Cột 2: mount point
- Cột 3: Loại file system. Ví dụ: ext2, ext3, ext4,...
- Cột 4: Mount option: auto, no-auto, user, no-user, ro, rw... Option mặc định là "default" bao gồm các tính năng: rw, suid, dev, exec, auto, nouser.
- Cột 5: tính năng DUMP dùng để backup. Mặc định là 0 trong hầu hết các trường hợp (nghĩa là không cần dump, nếu để 1 nó sẽ tạo ra file back up cho mình).
- Cột 6: Sử dụng fsck (filesystem check) để check ổ đĩa có lỗi hay không. Để 0 để không check file system tại phân vùng này.

- dùng câu lệnh mount -a để đọc hết các dòng trong file fstab và kết nối lại
- sau đó dùng mount để kiểm tra.
## 3. mount iso Centos 7 create local yum
### 3.1 chuẩn bị
- VM máy Centos 7 64bit
- add iso centos 7 vào VM
### 3.2 Tiến hành
- Kiểm tra cd/dvd:
```
[root@localhost cong]# lsblk
NAME            MAJ:MIN RM  SIZE RO TYPE  MOUNTPOINT
sda               8:0    0   40G  0 disk
├─sda1            8:1    0    1G  0 part  /boot
└─sda2            8:2    0   39G  0 part
  ├─centos-root 253:0    0   37G  0 lvm   /
  └─centos-swap 253:1    0    2G  0 lvm   [SWAP]
sdb               8:16   0   10G  0 disk
└─sdb1            8:17   0   10G  0 part
  └─md0           9:0    0   20G  0 raid5
sdc               8:32   0   11G  0 disk
└─sdc1            8:33   0   11G  0 part
  └─md0           9:0    0   20G  0 raid5
sdd               8:48   0   20G  0 disk
└─sdd1            8:49   0   20G  0 part
  └─md0           9:0    0   20G  0 raid5
sr0              11:0    1  4.3G  0 rom   
sr1              11:1    1  4.3G  0 rom
```

- Mout cdrom vào thư mục /cong
```
[root@localhost ~]# mkdir /cong
[root@localhost cong]# mount /dev/cdrom /cong
mount: /dev/sr0 is write-protected, mounting read-only
```
- Backup file repo
```
[root@localhost ~]# mv /etc/yum.repos.d/*.repo /yumm
```
- Tạo repo file
```
[root@localhost cong]# vi /etc/yum.repos.d/cloud-local.repo
```
Nội dung file:
```
[cloudlocal]
name=LocalRepository
baseurl=file:///cong
enabled=1
gpgcheck=1
gpgkey=file:///cong/RPM-GPG-KEY-CentOS-7
```
Trong đó:
- [ cloudlocal] : Tên repo sẽ hiển thị trong quá trình cài đặt gói
- name : Tên của Repo
- baseurl : Vị trí package
- enabled : Bật sử dụng Repo
- gpgcheck : Bật cài đặt an toàn. Nếu set giá trị là 0 thì không cần để ý giá trị gpgkey
- gpgkey : Vị trí lưu key


- Xoá yum cached
```
yum clean all
```

- Cài đặt thử gói http:

![](/Linux-Basic/Storage/image/aaa.png)

# III. Thuật ngữ liên quan
MBR (Master Boot Record) và GPT (GUID Partition Table) là hai cách khác nhau để lưu trữ các thông tin phân vùng trên một ổ đĩa.
## 1. MBR
- MBR là viết tắt của Master Boot Record. Chuẩn MBR được giới thiệu cùng IBM PC DOS 2.0 vào năm 1983.

- Sở dĩ nó được gọi là Master Boot Record vì MBR là một khu vực khởi động đặc biệt nằm ở đầu một ổ đĩa. Khu vực này có một Boot loader được cài đặt trên hệ điều hành và các thông tin về phân vùng Logical của ổ đĩa.

- Về Boot loader, bạn có thể hiểu nó là chương trình khởi động hệ thống và hệ điều hành đã được lập trình sẵn và đặt trong ROM.

- Nói rộng hơn, Boot loader là một đoạn mã nhỏ được thực thi trước khi hệ điều hành bắt đầu chạy và nó cho phép nhà sản xuất thiết bị quyết định những tính năng nào người sử dụng được phép dùng hoặc bị hạn chế.

- Nếu cài đặt hệ điều hành Windows, các bit ban đầu của Boot Loader Windows sẽ cư trú tại đây- đó là lý do tại sao bạn phải sửa chữa lại MBR nếu nó bị ghi đè và Windows sẽ không thể khởi động được. Nếu cài đặt hệ điều hành Linux, Boot Loader GRUB thường sẽ nằm trong MBR.

- MBR làm việc với các ổ đĩa cs kích thước lên đến 2 TB, nhưng nó không thể xử lý ổ đĩa có dung lượng lớn hơn 2 TB.

- Ngoài ra MBR chỉ hỗ trợ 4 phân vùng chính. Nếu muốn nhiều phân vùng hơn, bạn phải thực hiện chuyển đổi 1 trong những phân vùng chính thành "extended partition" (phân vùng mở rộng) và tạo phân vùng Logical bên trong phân vùng đó.

## 2. GPT
- GPT là viết tắt của GUID Partition Table. Đây là một chuẩn mới, đang dần thay thế chuẩn MBR.

- GPT liên quan với UEFI - UEFI thay thế cho BIOS, UEFI có giao diện và tính năng hiện đại hơn , và GPT cũng thay thế các hệ thống phân vùng MBR xa xưa bằng các tính năng, giao diện hiện đại hơn.

- Lí do được gọi là GUID Partition Table bởi lẽ mỗi phân vùng trên ổ đĩa của bạn có một "globally unique identifier," hay viết tắt là GUID.

- Hệ thống này không giới hạn của MBR. Ổ đĩa có thể nhiều hơn, lớn hơn nhiều và kích thước giới hạn sẽ phụ thuộc vào hệ điều hành và hệ thống tập tin của nó.

- GPT cho phép một số lượng không giới hạn các phân vùng, và giới hạn này sẽ là hệ điều hành của bạn - Windows cho phép lên đến 128 phân vùng trên một ổ đĩa GPT, và bạn không cần phải tạo Extended partition (phân vùng mở rộng).

- Trên ổ đĩa MBR, dữ liệu phân vùng và dữ liệu khởi động được lưu trữ ở một vị trí. Nếu dữ liệu này bị ghi đè hoặc bị hỏng, khi đó bạn sẽ gặp phải các rắc rối. Ngược lại, GPT lưu trữ nhiều bản sao của các dữ liệu này trên đĩa, do đó bạn có thể khôi phục các dữ liệu nếu các dữ liệu này bị lỗi.

- GPT cũng lưu trữ các giá trị Cyclic Redundancy Check (CRC) để kiểm tra xem các dữ liệu này còn nguyên vẹn hay không. Nếu dữ liệu này bị lỗi, GPT sẽ phát hiện được vấn đề và cố gắng khôi phục các dữ liệu bị hư hỏng từ một vị trí khác trên ổ đĩa.

- MBR không có cách nào để biết được dữ liệu của nó đã bị lỗi. Bạn chỉ có thể nhận biết được các sự cố khi quá trình khởi động không thành công hoặc phân vùng ổ đĩa của bạn biến mất.

**Sự khác biệt giữa MBR và GPT là gì?**

Ổ đĩa MBR hay GPT đều có thể là loại ổ cơ bản hoặc ổ động. So với ổ đĩa MBR, ổ đĩa GPT hoạt động tốt hơn ở các khía cạnh sau:

- GPT hỗ trợ các ổ đĩa có dung lượng lớn hơn 2TB trong khi MBR thì không.

- Kiểu phân vùng ổ đĩa GPT hỗ trợ các volume có dung lượng lên đến 18 exabyte và tới 128 phân vùng trên mỗi ổ đĩa, trong khi kiểu phân vùng ổ đĩa MBR chỉ hỗ trợ các volume có dung lượng lên đến 2 terabyte và tối đa 4 phân vùng chính trên mỗi ổ đĩa (hoặc 3 phân vùng chính, một phân vùng mở rộng và ổ đĩa logic không giới hạn).

- Ổ đĩa GPT cung cấp độ tin cậy cao hơn, nhờ khả năng bảo vệ sao chép và kiểm tra dự phòng theo chu kỳ (CRC) của bảng phân vùng. Không giống như các ổ đĩa được phân vùng MBR, dữ liệu quan trọng đối với hoạt động của nền tảng được đặt trong những phân vùng thay vì các sector không được phân vùng hoặc ẩn.

- Ổ đĩa được phân vùng GPT có các bảng phân vùng chính và dự phòng để cải thiện tính toàn vẹn của cấu trúc dữ liệu phân vùng.

Thông thường, MBR và BIOS (MBR + BIOS), GPT và UEFI (GPT + UEFI) đi đôi với nhau. Điều này là bắt buộc đối với một số hệ điều hành (ví dụ: Windows), nhưng lại là tùy chọn đối với những hệ điều hành khác (ví dụ: Linux). Khi chuyển đổi ổ đĩa hệ thống sang ổ GPT, hãy đảm bảo rằng bo mạch chủ của máy tính hỗ trợ chế độ khởi động UEFI.

**Khả năng tương thích**

- Ổ GPT bao gồm một "protective MBR.". Nếu bạn cố gắng quản lý một đĩa GPT bằng một công cụ cũ chỉ có thể đọc MBRs, công cụ này sẽ nhìn thấy một phân vùng duy nhất kéo dài trên toàn bộ ổ đĩa.

- MBR đảm bảo các công cụ cũ không bị nhầm lẫn drive GPT cho một ổ đĩa chưa phân vùng và ghi đè lên dữ liệu GPT của nó bằng một MBR mới. Nói cách khác, MBR bảo vệ bảo vệ các dữ liệu GPT không bị ghi đè.

- Windows có thể khởi động từ GPT trên UEFI – dựa trên máy tính chạy phiên bản 64-bit của Windows 8.1, 8, 7, Vista, và các phiên bản máy chủ tương ứng. Tất cả các phiên bản của Windows 8.1, 8, 7, Vista và có thể đọc ổ đĩa GPT và sử dụng chúng để lưu dữ liệu.

- Ngoài ra các hệ điều hành hiện đại khác cũng có thể sử dụng GPT. Linux đã xây dựng hỗ trợ GPT. Apple Intel Mac không còn sử dụng chương trình của Apple APT (Apple Partition Table) mà sử dụng GPT để thay thế.
## 3. File System Type 
Hệ thống tệp là một cơ chế để quản lý dữ liệu thuộc tính như tên tệp và ngày cập nhật, và dữ liệu tệp chính từ dữ liệu được lưu trữ trong thiết bị lưu trữ như đĩa cứng và hệ thống tệp được sử dụng khác nhau tùy thuộc vào hệ điều hành.

Trong trường hợp của Linux, hệ thống tệp được chấp nhận khác nhau tùy thuộc vào bản phân phối, nhưng có vẻ như ext3 và ext4 thường được chấp nhận.

Ext - Extended File System

**Một số loại chính**

Tên|	Kích thước tệp tối đa|	Mô tả
|---|---|---|
ext2|	2TB	|Nó là một hệ thống tập tin được sử dụng rộng rãi trong hệ điều hành Linux. Một phần mở rộng của hệ thống tệp ext ban đầu.
ext3|	16GB-2TB|	Một chức năng hệ thống ghi nhật ký được thêm vào ext2. Hệ thống tệp chính trên Linux. Phạm vi ngày dễ nhận biết là từ ngày 14 tháng 12 năm 1901 đến ngày 18 tháng 1 năm 2038.
ext4|	16TB|	Hỗ trợ kích thước âm lượng lên đến 1EB và kích thước tệp lên đến 16TB.Phạm vi ngày từ 14 tháng 12 năm 1901 đến 25 tháng 4 năm 2514 và có thể được sử dụng khi còn sống.Dấu thời gian hỗ trợ nano giây. Có thể là hệ thống tệp chính trong tương lai. Phản hồi tốt hơn ext3.
ReiserFS|	16TB|	Một hệ thống tệp nhật ký phù hợp để xử lý các tệp nhỏ. Bạn đang sử dụng nó? Nó đã được SUSE thông qua.|
## 4. UUID là gì
UUID là một ID để quản lý và xác định thiết bị. Mặc dù nó không được quản lý để không ai có thể sao chép nó, nó tồn tại như một ID duy nhất để nhận dạng thiết bị và UUID cũng được gán cho đĩa cứng.

Để tìm UUID của đĩa cứng, hãy sử dụng lệnh blkid.

Nếu bạn ghi một bản ghi bằng UUID trong fstab, nếu tên thiết bị bị thay đổi do thay đổi vật lý của kết nối đĩa cứng hoặc thêm / thay đổi thiết bị (ví dụ: sda1 được thay đổi thành sdb1). Tuy nhiên, bản ghi được ghi trong fstab sẽ chọn thiết bị có UUID được chỉ định. Nếu fstab được mô tả bằng tên thiết bị, nó có thể không khởi động bình thường nếu tên thiết bị được thay đổi.

UUID của đĩa cứng cũng được tạo khi tạo hệ thống tệp. Bạn có thể thêm bất kỳ UUID nào bằng cách chỉ định tùy chọn -U cho lệnh mkfs.

```
# mkfs -t ext4 -L hdd1 -U aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa / dev / sdb5 ← Chỉ định UUID
```
# Tài liệu tham khảo

1. https://vi.wikipedia.org/wiki/Mount_(m%C3%A1y_t%C3%ADnh)
2. https://man7.org/linux/man-pages/man8/mount.8.html
3. https://quantrimang.com/gpt-va-mbr-khac-nhau-nhu-the-nao-khi-phan-vung-o-dia-122635
4. https://kazmax.zpp.jp/linux_beginner/mount_hdd.html
5. https://kazmax.zpp.jp/linux_beginner/mkfs.html
6. https://news.cloud365.vn/huong-dan-tao-local-yum-repository-tren-centos-7-voi-dia-iso-dvd/