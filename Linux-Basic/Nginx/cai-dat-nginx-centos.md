# Hướng dẫn cài đặt Nginx trên Centos 7

Nginx Open Source có 2 version:
- Mainline - Bao gồm các tính năng và bản vá mới nhất, luôn được cập nhật, đáng tin cậy. Nhưng có thể bao gồm 1 số mô-đun thử nghiệm và có thể có 1 số lỗi mới.
- Stable - Không có các tính năng mới nhất, nhưng luôn có các bản vá quang trọng. Đề xuất cho `production servers`.

![](./image/NGINX-logo.png)
## Khởi tạo Nginx Repo
Thiết lập kho lưu trữ cho Centos bằng cách tạo tệp `nginx.repo` trong `/etc/yum.repos.d`

```
echo '#/etc/yum.repos.d/nginx.repo
[nginx]
name= nginx repo
baseurl=https://nginx.org/packages/mainline/<OS>/<OSRELEASE>/$basearch/
gpgcheck=0
enabled=1' > /etc/yum.repos.d/nginx.repo
```

Trong đó:
- `/mainline` trong `baseurl` trỏ đến phiên bản mới nhất của NGINX Open Source; xoá nó để tải về bản `Stable`
- `<OS>` là 1 trong 2:
  - `rhel`
  - `centos`
- `<OSRELEASE>` là số phiên bản. Ví dụ:
  - `6`
  - `6._x_`
  - `7`
  - `7._x_`
  - ...
- Ví dụ: để tải phiên bản `Stable` cho `Centos 7`:
```
echo '#/etc/yum.repos.d/nginx.repo
[nginx]
name= nginx repo
baseurl=https://nginx.org/packages/centos/7/$basearch/
gpgcheck=0
enabled=1' > /etc/yum.repos.d/nginx.repo
```

## Thực hiện cài đặt NGINX

Cập nhật thông tin mới nhất cho repo:
```
yum update -y
```

Bắt đầu cài đặt Nginx Open Source
```
yum install nginx -y
```