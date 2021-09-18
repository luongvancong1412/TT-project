#Cài đặt và cấu hình PowerDNS trên Centos 7

- [rm -fr /var/www/html/poweradmin-2.1.7/install/](#rm--fr-varwwwhtmlpoweradmin-217install)
    - [2.4 Thêm, chỉnh sửa và xóa zone DNS trong PowerDNS](#24-thêm-chỉnh-sửa-và-xóa-zone-dns-trong-powerdns)
      - [2.4.1 Để thêm zone mới, nhấp vào “**Add master zone**”:](#241-để-thêm-zone-mới-nhấp-vào-add-master-zone)
      - [2.4.2 Thêm các loại Bản ghi DNS:](#242-thêm-các-loại-bản-ghi-dns)
## 1. Mô hình mạng
![](/DNS/image/001.png)
## 2. Cài đặt PowerDNS trên DNS server
- PowerDNS là một máy chủ DNS chạy trên Linux / Unix. 
- Nó có thể được cấu hình với các phụ trợ khác nhau bao gồm BIND, MySQL,...
- Nó cũng có thể được thiết lập như một đệ quy DNS chạy như một quy trình riêng biệt trên máy chủ.
- Trong bài này sử dụng hiên bản hiện có trong kho EPEL là 3.4.3 . 
### 2.1 Cài đặt PowerDNS với MariaDB Backend
- Trước tiên,tải kho EPEL cho máy chủ, sử dụng lệnh:
```# yum install epel-release.noarch -y```

![](/DNS/image/002.png)
*Tải kho lưu trữ epel*

- Bước tiếp theo là cài đặt MariaDB bằng cách chạy lệnh sau:
```# yum -y install mariadb-server mariadb```

![](/DNS/image/003.png)
*Cài đặt máy chủ MariaDB*

- Tiếp theo, chúng ta sẽ cấu hình MySQL để kích hoạt và khởi động khi khởi động hệ thống:

```# systemctl enable mariadb.service```
```# systemctl start mariadb.service```

![](/DNS/image/004.png)
*Bật Khởi động Khởi động Hệ thống MariaDB*

- Bây giờ dịch vụ MySQL đang chạy
- Tiếp theo bảo thiết lập mật khẩu cho MariaDB:
```# mysql_secure_installation```
- Nhập mật khẩu hiện tại(không có mật khẩu nhấn enter)
![](/DNS/image/005.png)

- Cài mật khẩu root:
![](/DNS/image/006.png)

- Xoá người dùng ẩn danh: chọn ```y```
![](/DNS/image/007.png)

- Không cho phép đăng nhập từ xa: chọn ``n``
![](/DNS/image/008.png)

Xóa CSDL test và truy cập vào nó: ```y```
![](/DNS/image/009.png)

Reload bảng privilege bây giờ : ```y```
![](/DNS/image/010.png)

- Cấu hình MariaDB được thực hiện thành công.
- Tiếp theo, cài đặt PowerDNS:
```# yum -y install pdns pdns-backend-mysql```
![](/DNS/image/011.png)
*Cài đặt PowerDNS với MariaDB Backend*

- Tiếp theo, thiết lập cơ sở dữ liệu MySQL cho dịch vụ PowerDNS . 
- Kết nối với máy chủ MySQL và sẽ tạo một cơ sở dữ liệu với tên ```powerdns```:


```# mysql -u root -p```
```MariaDB [(none)]> CREATE DATABASE powerdns;```
![](/DNS/image/012.png)
*Tạo cơ sở dữ liệu PowerDNS*

- Tạo một người dùng ```powerdns``` cho cơ sở dữ liệu:
```MariaDB [(none)]> GRANT ALL ON powerdns.\* TO 'powerdns'@'localhost' IDENTIFIED BY 'conglab';```
```MariaDB [(none)]> FLUSH PRIVILEGES;```
![](/DNS/image/013.png)
*Tạo người dùng PowerDNS*

- Trong đó:
- - Powerdns là user
- - Conglab là password

- Tạo các bảng ```domains```, ```records``` và ```supermasters ``` trong CSDL ```powerdns```. 

- Tạo bảng ```domains``` cho PowerDNS
```
MariaDB [(none)]> USE powerdns;
MariaDB [(none)]> CREATE TABLE domains(```
    id INT auto_increment,```
    name VARCHAR(255) NOT NULL,```
    master VARCHAR(128) DEFAULT NULL,
    last_check INT DEFAULT NULL,
    type VARCHAR(6) NOT NULL,
    notified_serial INT DEFAULT NULL,
    account VARCHAR(40) DEFAULT NULL,
    primary key (id)
);
```
![](/DNS/image/015.png)

- Tạo miền chỉ mục cho PowerDNS
![](/DNS/image/016.png)

- Tạo bảng ```records```:
```
CREATE TABLE records (
    id INT auto_increment,
    domain_id INT DEFAULT NULL,
    name VARCHAR(255) DEFAULT NULL,
    type VARCHAR(6) DEFAULT NULL,
    content VARCHAR(255) DEFAULT NULL,
    ttl INT DEFAULT NULL,
    prio INT DEFAULT NULL,
    change_date INT DEFAULT NULL,
    primary key(id)
);
```
![](/DNS/image/017.png)

- Tạo các chỉ mục sau cho bảng ```records```:
```
CREATE INDEX rec_name_index ON records(name);
CREATE INDEX nametype_index ON records(name,type);
CREATE INDEX domain_id ON records(domain_id);
```

![](/DNS/image/018.png)

- Tạo bảng ```supermasters```:
```
CREATE TABLE supermasters (
    ip VARCHAR(25) NOT NULL,
    nameserver VARCHAR(255) NOT NULL,
    account VARCHAR(40) DEFAULT NULL
);
```
![](/DNS/image/019.png)

- Thoát khỏi MySQL bằng lệnh:
```
MariaDB [(none)]> quit;
```
![](/DNS/image/020.png)

### 2.2. Cấu hình PowerDNS: ```/etc/pdns/pdns.conf```
- Tiếp theo cấu hình ```PowerDNS``` sử dụng ```MySQL``` để lưu trữ các tệp và bản ghi Zone.
- Đầu tiên, sao lưu tệp cấu hình cũ.
```
# cp /etc/pdns/pdns.conf /etc/pdns/pdns.conf.bak
```

![](/DNS/image/021.png)

- Sau đó, mở tệp ```/etc/pdns/pdns.conf```:

```# vi /etc/pdns/pdns.conf```
- Thêm các dòng sau vào cuối file ```/etc/pdns/pdns.conf```.
```
# MySQL Configuration
# Launch gmysql backend
launch=gmysql
# gmysql parameters
gmysql-host=localhost
gmysql-dbname=powerdns
gmysql-user=powerdns
gmysql-password=conglab
```
- Bật dịch vụ và tự khởi động cùng hệ thống:

```
# systemctl enable pdns
# systemctl start pdns
```
![](/DNS/image/022.png)

### 2.3 Cài đặt PowerAdmin
- PowerAdmin là một giao diện web thân thiện được thiết kế để quản lý các máy chủ PowerDNS. 
- Nó được viết bằng PHP, nên cần cài đặt PHP và một máy chủ web (Apache):
```
# yum install httpd php php-devel php-gd php-imap php-ldap php-mysql php-odbc php-pear php-xml php-xmlrpc php-mbstring php-mcrypt php-mhash gettext
```

![](/DNS/image/023.png)

- PowerAdmin cũng cần hai gói PEAR:```php-pear-DB``` và ```php-pear-MDB2-Driver-mysql```

```# yum -y install php-pear-DB php-pear-MDB2-Driver-mysql```

![](/DNS/image/024.png)

Cấu hình khởi động và thiết lập để Apache bắt đầu khi khởi động hệ thống:

```
# systemctl enable httpd.service
# systemctl start httpd.service
```
![](/DNS/image/025.png)

- Tải xuống gói PowerAdmin trong ```/var/www/html/```

```
# cd /var/www/html/
# wget http://downloads.sourceforge.net/project/poweradmin/poweradmin-2.1.7.tgz
```

![](/DNS/image/026.png)

- Giải nén tệp vừa tải:
```
# tar xfv poweradmin-2.1.7.tgz
```
![](/DNS/image/027.png)

Trên client, khởi động trình cài đặt web của PowerAdmin trên trình duyệt bằng địa chỉ:

*http://192.168.0.102/poweradmin-2.1.7/install/*

- Quá trình cài đặt bắt đầu:
[1] Chọn ngôn ngữ cho PowerAdmin của bạn. Chọn một cái bạn muốn sử dụng và nhấp vào nút “ **Go to step 2** ”.
![](/DNS/image/028.png)

[2] Trình cài đặt sẽ yêu cầu bạn có cơ sở dữ liệu **PowerDNS** :
![](/DNS/image/029.png)
Nhấn vào nút **Go to step 3**
[3] Nhập ```username```, ```password```, ```database``` đã tạo trước đó:
![](/DNS/image/030.png)
Nhấn vào nút **Go to step 4**
[4]Tạo một người dùng mới với các quyền hạn chế cho Poweradmin. Các trường cần nhập là:
1. **Username** - tên người dùng cho PowerAdmin.
2. **Password** - mật khẩu cho người dùng trên.
3. **Hostmaster** - Khi tạo bản ghi SOA và bạn chưa chỉ định hostmaster, giá trị này sẽ được sử dụng.
4. **Primary nameserver ** - giá trị sẽ được sử dụng làm máy chủ định danh chính khi tạo vùng DNS mới.
5. **Secondary nameserver** - giá trị sẽ được sử dụng làm máy chủ định danh chính khi tạo vùng DNS mới.

![](/DNS/image/031.png)
Nhấn vào nút **Go to step 5**
[5]**Poweradmin** sẽ yêu cầu bạn tạo người dùng cơ sở dữ liệu mới với các quyền hạn chế trên các bảng cơ sở dữ liệu. Nó sẽ cung cấp cho bạn code mà bạn sẽ cần đặt trong bảng điều khiển MySQL:
- Copy đoạn code:
![](/DNS/image/032.png)
Trên server, chạy lệnh:
```# mysql -u root -p```
- Paste command step 5 vào để phân quyền cho người dùng mới:
![](/DNS/image/033.png)
- Quay lại client, nhấn vào nút **Go to step 6**
[Step 6] Trình cài đặt sẽ cố gắng tạo tệp cấu hình của nó trong **/var/www/html/poweradmin-2.1.7/inc** .
- Tên tệp là **config.inc.php** .
![](/DNS/image/034.png)

- Trong trường hợp tập lệnh không thể ghi tệp đó, bạn có thể tạo nó theo cách thủ công bằng cách sao chép văn bản và đặt nó vào tệp đã đề cập ở trên: Copy đoạn code vào file  ```/var/www/html/poweradmin-2.1.7/inc/config.inc.php```
```
<?php
$db_host		= 'localhost';
$db_user		= 'powercong';
$db_pass		= 'conglab';
$db_name		= 'powerdns';
$db_type		= 'mysql';
$db_layer		= 'PDO';
$session_key		= '-hu~fz~U(cIfY1yvx+NtmSgRGBuykiNt1=NZSc&tn61Qsc';
$iface_lang		= 'en_EN';
$dns_hostmaster		= 'dns.conglab.com';
$dns_ns1		= 'ns1.conglab.com';
$dns_ns2		= 'ns2.conglab.com';
![](/DNS/image/035.png)
- Quay lại client, nhấn vào nút **Go to step 7**
[Step 7] Thông báo rằng quá trình cài đặt đã hoàn tất và sẽ nhận được thông tin về cách truy cập cài đặt Poweradmin của bạn:
![](/DNS/image/036.png)

- Tiếp theo, quay về máy server xóa thư mục “ **install** ” khỏi thư mục gốc của Poweradmin bằng lệnh sau:
```
# rm -fr /var/www/html/poweradmin-2.1.7/install/
```
- Sau đó, Truy cập lại poweradmin tại:
http://192.168.100.123/poweradmin-2.1.7/

![](/DNS/image/037.png)
### 2.4 Thêm, chỉnh sửa và xóa zone DNS trong PowerDNS
#### 2.4.1 Để thêm zone mới, nhấp vào “**Add master zone**”:
![](/DNS/image/038.png)

Cần chú ý các trường sau:
1. Zone name - miền mà bạn sẽ thêm khu vực.
1. Owner - đặt chủ sở hữu của vùng DNS.
1. Template - mẫu DNS - không để lại.
1. DNSSEC - Tiện ích mở rộng bảo mật hệ thống tên Donany (tùy chọn - kiểm tra nếu bạn cần).

Nhấp vào nút “ Add zone ” để thêm vùng DNS.

![](/DNS/image/039.png)

- Sau đó, tạo một tệp vùng PTR. Để làm điều đó, hãy nhấp lại vào liên kết **Add master zone** . Nhập tên tệp Zone PTR. Ở đây là: ```100.168.192.in-addr.arpa```
![](/DNS/image/040.png)

- Bạn có thể xem các tệp Zone mới được tạo trong ```list zones``` .

![](/DNS/image/041.png)

Hình dưới là các tệp vùng mới được thêm vào.
![](/DNS/image/042.png)

#### 2.4.2 Thêm các loại Bản ghi DNS:
Để thêm Bản ghi mới, hãy nhấp vào nút Chỉnh sửa của tệp vùng tương ứng.
![](/DNS/image/043.png)

Nhập tên, loại, nội dung, chi tiết TTL. Sau đó, nhấp vào nút Thêm bản ghi .
![](/DNS/image/044.png)

Tương tự như vậy, có thể tạo một số loại bản ghi khác.
![](/DNS/image/045.png)

Bản ghi ns2.conglab.com :
![](/DNS/image/046.png)

Nhấp vào nút Chỉnh sửa trên các tệp PTR.
![](/DNS/image/047.png)
