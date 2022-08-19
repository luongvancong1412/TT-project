<h1>Cài Đặt Zimbra Ubuntu 20.04</h1>

- [I. Cập Nhật Và Nâng Cấp Linux](#i-cập-nhật-và-nâng-cấp-linux)
- [II. Chỉnh Sửa Tên Máy Chủ Và Tệp Máy Chủ Linux](#ii-chỉnh-sửa-tên-máy-chủ-và-tệp-máy-chủ-linux)
- [III. Cài Đặt Dnsmasq](#iii-cài-đặt-dnsmasq)
  - [1. Tắt systemd-resolve (Vì dns sử dụng port 53)](#1-tắt-systemd-resolve-vì-dns-sử-dụng-port-53)
  - [2. Định Cấu Hình Tệp Resolv](#2-định-cấu-hình-tệp-resolv)
  - [3. Định Cấu Hình Dnsmasq](#3-định-cấu-hình-dnsmasq)
- [IV. Tải Xuống Zimbra Collaboration Open Source Edition](#iv-tải-xuống-zimbra-collaboration-open-source-edition)
- [V. Cài Đặt Zimbra](#v-cài-đặt-zimbra)
  - [1. Menu DNS Cache](#1-menu-dns-cache)
  - [2. Quản Trị Mật Khẩu Menu](#2-quản-trị-mật-khẩu-menu)
- [V. Truy Cập Zimbra Dashaboard Admin](#v-truy-cập-zimbra-dashaboard-admin)


# I. Cập Nhật Và Nâng Cấp Linux 
```
sudo apt update && apt upgrade 
```
# II. Chỉnh Sửa Tên Máy Chủ Và Tệp Máy Chủ Linux

```
sudo vi /etc/hostname
```
```
mail.cong07019.com
```
```
sudo vi /etc/hosts
```
```
192.168.10.129 mail.cong07019.com		mail
```
```
sudo reboot
```

# III. Cài Đặt Dnsmasq

## 1. Tắt systemd-resolve (Vì dns sử dụng port 53)

```
sudo systemctl disable systemd-resolved
sudo systemctl stop systemd-resolved
```

## 2. Định Cấu Hình Tệp Resolv

```
sudo ls -lh /etc/resolv.conf
```
```
sudo rm -f /etc/resolv.conf
```
```
sudo vi /etc/resolv.conf
```
```
nameserver 8.8.8.8
```

```
sudo apt install dnsmasq -y
```

## 3. Định Cấu Hình Dnsmasq

```
sudo cp /etc/dnsmasq.conf /etc/dnsmasq.conf.bak
```

```
sudo vi /etc/dnsmasq.conf
```

```
server= 192.168.10.129
domain=cong07019.com
mx-host= cong07019.com, mail.cong07019.com, 5
mx-host= mail.cong07019.com, mail.cong07019.com, 5
listen-address=127.0.0.1
```

```
sudo systemctl restart dnsmasq
```


Tìm bản ghi A của Máy chủ Zimbra
```
dig A mail.cong07019.com
```

Tiếp tục với thử nghiệm miền bản ghi MX
```
dig MX cong07019.com
```

# IV. Tải Xuống Zimbra Collaboration Open Source Edition

```
wget https://files.zimbra.com/downloads/8.8.15_GA/zcs-8.8.15_GA_4179.UBUNTU20_64.20211118033954.tgz
```

giải nén tệp zimbra đã được tải xuống
```
tar zxvf zcs-8.8.15_GA_4179.UBUNTU20_64.20211118033954.tgz
cd zcs-8.8.15_GA_4179.UBUNTU20_64.20211118033954
```

# V. Cài Đặt Zimbra

```
sudo ./install.sh
```

Hiện thông báo về thỏa thuận Cấp phép Phần mềm, hãy chọn `Y `

Trong cài đặt gói, chọn `Y` cho mỗi gói ngoại trừ gói `zimbra-imapd` .vì phiên bản vẫn đang ở giai đoạn Beta.

Khi hoàn tất, thông báo của hệ thống sẽ được thay đổi, hãy chọn `Yes`
```
The system will be modified. Continue? [N] y 
```

## 1. Menu DNS Cache

Chọn 5 là `zimbra-dnscache`, sau đó chọn 2 `(Các) địa chỉ IP DNS chính`

Điền vào nó với google dns là 8.8.8.8

Sau đó gõ `r` để quay lại

## 2. Quản Trị Mật Khẩu Menu
Nhấn phím `7` để thêm mật khẩu quản trị viên

Địa chỉ các mục chưa định cấu hình (**) (? - trợ giúp) 7

Sau đó, bây giờ để tạo Mật khẩu quản trị, hãy nhấn `4` . Chúng tôi sẽ được yêu cầu đặt mật khẩu quản trị viên. Nhập Mật khẩu phải chứa 6 ký tự .

Chọn hoặc 'r' cho menu trước [r] 4
```
cong07019@
```
Sau khi nhập mật khẩu, nhập Enter và nhấn phím 'r' trên bàn phím để quay lại Menu chính

Chọn hoặc 'r' cho menu trước [r]

Bây giờ để lưu cấu hình đã hoàn thành nhưng nhấn phím 'a' trên bàn phím.

Chọn từ menu hoặc nhấn 'a' để áp dụng cấu hình (? - help) a

Và sẽ có thông báo lưu cấu hình đã thực hiện Gõ 'Có'

Lưu dữ liệu cấu hình vào một tệp? [Vâng vâng 

Hệ thống sẽ được sửa đổi - tiếp tục? [Không] Có

Sau đó Enter và đợi Zimbra hoàn thành cấu hình đã tạo trước đó.

Tiếp theo là thông báo Thông báo cho Zimbra về việc cài đặt của bạn? [Có], sau đó chọn Không

# V. Truy Cập Zimbra Dashaboard Admin


Mở trình duyệt web và nhập

https: // ip-address: 7071


<a href="https://imgur.com/8B77Cd8"><img src="https://i.imgur.com/8B77Cd8.png" title="source: imgur.com" /></a>

User đăng nhập: admin@mail.cong07019.com/cong07019@