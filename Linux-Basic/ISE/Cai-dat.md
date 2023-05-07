
# 1. Cài đặt

`By Conglv 08/05/2023`

*Summary*
- [1. Cài đặt](#1-cài-đặt)
  - [1. Cấu trúc Installation CD](#1-cấu-trúc-installation-cd)


##  1. <a name='CutrcInstallationCD'></a>Cấu trúc Installation CD

cdrom gồm:dosutils, images, packages (Cấu trúc này có thể khác tuỳ nội dung và mục đích sử dụng của đĩa)

1. `packages`: chứa các gói pm đã được cài đặt trước. (chứa các gói phần mềm cần thiết cho việc cài đặt hệ điều hành hoặc phần mềm trên DOS. Các gói phần mềm này có thể được tổ chức theo danh mục như gói phần mềm hệ thống, gói ứng dụng, gói trình điều khiển và các gói khác.)
    
    Tuỳ vào bản phân phối mà có tên khác nhau:
    
    - debian: dist
    - mandrake: mandrake
    - redhat: RedHat
    - suse: suse
    - feddora: Fedora
2. `images`: Chứa ảnh của Linux với công dụng:
    1. Khởi động quá trình cài đặt
    2. Cung cấp module nhân
    3. Khôi phục lại hệ thống

> Images có thể được ghi vào CD, USB
> 
- Trong file image chứa file và thư mục con (chứa các tập tin hình ảnh như ảnh nền, biểu tượng và các tập tin hình ảnh khác.)
- Truy cập đến file này bằng cách mount vào một thiết bị loop

```jsx
mount -o loop /path/to/Image /mnt
```

1. `Dosutils`: **DOSUTILS là một tập hợp các tiện ích (utility) và công cụ được sử dụng trên hệ điều hành DOS (Disk Operating System) của Microsoft.** 

Các tiện ích trong DOSUTILS bao gồm các lệnh dòng lệnh, tiện ích kiểm tra hệ thống, tiện ích quản lý tệp tin và thư mục, và các tiện ích khác để hỗ trợ việc quản lý hệ thống DOS.

Các tiện ích trong DOSUTILS bao gồm:

- CHKDSK: Tiện ích kiểm tra hệ thống tập tin và sửa chữa các lỗi.
- FORMAT: Tiện ích định dạng ổ đĩa.
- SYS: Tiện ích tạo một bộ khởi động DOS trên một ổ đĩa.
- FDISK: Tiện ích quản lý phân vùng ổ đĩa.
- XCOPY: Tiện ích sao chép tệp tin và thư mục.
- ATTRIB: Tiện ích quản lý các thuộc tính của tệp tin và thư mục.
- TREE: Tiện ích hiển thị cấu trúc thư mục dưới dạng cây.
- MEM: Tiện ích hiển thị thông tin về bộ nhớ hệ thống.

DOSUTILS được cung cấp kèm theo các phiên bản của hệ điều hành DOS của Microsoft, và chúng đã được sử dụng rộng rãi trong quá khứ để hỗ trợ quản lý hệ thống DOS. Tuy nhiên, với sự phát triển của các hệ điều hành đa nhiệm và đồ họa, các tiện ích trong DOSUTILS đã trở nên ít được sử dụng và đã được thay thế bởi các công cụ và tiện ích khác trên các hệ điều hành hiện đại.

> môi trường DOS là gì
> 
- Dos có nhiều phiên bản như: MS-DOS, IBM PC DOS, DR-DOS, FreeDOS, ROM-DOS, và PTS-DOS.
- DOS là viết tắt của Disk Operating System
- là **một hệ điều hành dòng lệnh** được phát triển bởi Microsoft Corporation vào những năm 1980.
- DOS được sử dụng phổ biến trên các máy tính cá nhân IBM PC và tương thích với nó trong những năm đầu của lịch sử máy tính cá nhân.
- DOS được thiết kế để **quản lý ổ đĩa cứng**, bao gồm đọc, ghi và xóa tệp và thư mục, và có thể chạy các chương trình được lưu trên ổ đĩa hoặc được nhập vào từ bàn phím.
- DOS đã trở thành một phần **quan trọng của lịch sử máy tính**, tuy nhiên, nó đã **được thay thế** bởi các hệ điều hành đồ họa như **Windows** và **macOS** trong những năm sau này.