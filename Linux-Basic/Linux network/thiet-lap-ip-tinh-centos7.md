# THIẾT LẬP ĐỊA CHỈ IP TĨNH TRÊN CENTOS 7 64BITS BẰNG NMCLI


## 1. Tổng quan
nmcli là viết tắt của Network Manager Command Line Interface.
Đó là một phần của NetworkManager quản lý các network subsystem.nmcli là một cách thức để tương tác với NetworkManager thông qua các dòng lệnh.

## 2. Hiển thị các thiết bị mạng sẵn có
Câu lệnh:
```
nmcli device
```

## 3. Cấu hình IP tĩnh
Thông số cài đặt:
```
IP address 192.168.40.37
Subnet mask 255.255.255.0
Gateway 192.168.40.1
DNS 8.8.8.8
```

Câu lệnh cấu hình sử dụng nmcli:
```
nmcli con mod ens33 ipv4.addresses 192.168.40.37/24
```
```
nmcli con mod ens33 ipv4.gateway 192.168.40.1
```
```
nmcli con mod ens33 ipv4.method manual
```
```
nmcli con mod ens33 ipv4.dns “8.8.8.8”
```

Reboot lại máy, kiểm tra lại địa chỉ IP.

