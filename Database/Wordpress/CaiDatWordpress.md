# Cài đặt Wordpress trên Centos 7
## Mô hình mạng

![](image/mhwp.png)

## Các bước cài đặt Wordpress
### 1. Cài đặt CSDL
- Cài đặt:

```# yum -y install mariadb-server```

- Đặt mật khẩu mariadb:

```mysql_secure_installation```

- Khởi động dịch vụ:


```# systemctl start mariadb```

```# systemctl enable mariadb```


```#firewall-cmd --add-service=mysql --permanent```

```#firewall-cmd --reload```

### 2. Cài đặt Apache
- Cài đặt:

```# yum install httpd –y```

- Khởi động dịch vụ:


```# systemctl start httpd```

```# systemctl enable httpd```

- Cấu hình tường lửa:

```firewall-cmd --permanent --zone=public --add-service=http```
```firewall-cmd --permanent --zone=public --add-service=https```
```firewall-cmd --reload```
### 3. Cài đặt PHP
- Cài đặt kho lưu trữ EPLE và Remi

```
# yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
# yum install http://rpms.remirepo.net/enterprise/remi-release-7.rpm
```
- Cài đặt yum-utils

```# yum install yum-utils -y```

- Cài đặt PHP 5.6


```# yum-config-manager --enable remi-php56```

```# yum install php php-mcrypt php-cli php-gd php-curl php-mysql php-ldap php-zip php-fileinfo```

- Kiểm tra phiên bản:

```# php -v```

### 4. Cài đặt Wordpress
#### 4.1 Tạo cơ sở dữ liệu
- Đăng nhập vào Mariadb:

```# mysql -u root -p```

- Tạo cơ sở dữ liệu bằng lệnh:

```CREATE DATABASE wordpressdb;```

- Tạo user cho CSDL wordpressdb:

```CREATE USER userwp@localhost IDENTIFIED BY '123456';```

- Cấp cho userwp quyền truy cập vào CSDL:
```GRANT ALL PRIVILEGES ON wordpressdb.* TO userwp@localhost IDENTIFIED BY '123456';```
- Lưu thay đổi:

```FLUSH PRIVILEGES;```
- Cuối cùng thoát MySQL:

```exit```
#### 4.2 Cài đặt WordPress

- Di chuyển tới nơi cài đặt Wordpress

```# cd /var/www/html```
- Cài đặt Wordpress từ internet:

```wget https://wordpress.org/latest.tar.gz```

Note: Nếu chưa có wget, có thể tải bằng lệnh yum sau:
    ```yum install wget```

- Giải nén tệp:

```tar -xzvf latest.tar.gz```

- Tạo tệp cấu hình từ tệp mẫu:
```cp wp-config-sample.php wp-config.php```

- Chỉnh sửa tệp cấu hình:

```# vi wp-config.php```

![](image/wpconfig.png)

#### 4.3 Kiểm tra
Trên Client: Truy cập  Wordpress bằng trình duyệt

![](image/xong.png)

# Tài liệu tham khảo

1. https://www.liquidweb.com/kb/how-to-install-wordpress-on-centos-7/
2. https://blog.cloud365.vn/linux/huong-dan-cai-dat-wordpress/