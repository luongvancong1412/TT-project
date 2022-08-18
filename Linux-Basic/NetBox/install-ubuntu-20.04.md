<h1>Cài đặt NetBox trên Ubuntu 20.04</h1>

<h2>Mục lục</h2>

- [Yêu cầu](#yêu-cầu)
- [Cài đặt NetBox trên Ubuntu 20.04](#cài-đặt-netbox-trên-ubuntu-2004)
  - [1. Cài đặt Database PostgreSQL](#1-cài-đặt-database-postgresql)
  - [2. Cài đặt Redis](#2-cài-đặt-redis)
  - [3. Cài đặt NetBox](#3-cài-đặt-netbox)
  - [4. Chạy tập lệnh nâng cấp](#4-chạy-tập-lệnh-nâng-cấp)
  - [5. Tạo Super User](#5-tạo-super-user)
  - [6. Kiểm tra ứng dụng](#6-kiểm-tra-ứng-dụng)
- [Tài liệu tham khảo](#tài-liệu-tham-khảo)


# Yêu cầu
|Dependency|Minimum Version |
|----------|----------------|
|  Python  |      3.8       |
|PostgreSQL|       10       |
|  Redis   |      4.0       |

# Cài đặt NetBox trên Ubuntu 20.04

## 1. Cài đặt Database PostgreSQL
> MySQL và các cơ sở dữ liệu quan hệ khác không được hỗ trợ.

```
sudo apt update
sudo apt install -y postgresql
```

Khởi động dịch vụ và cho phép nó chạy khi khởi động:
```
sudo systemctl start postgresql
sudo systemctl enable postgresql
```

Kiểm tra phiên bản cài đặt PostgreSQL > 10:
```
psql -V
```

<h3>Tạo cơ sở dữ liệu</h3>

```
sudo -u postgres psql
```

Tạo cơ sở dữ liệu và user
```
CREATE DATABASE netbox;
CREATE USER netbox WITH PASSWORD '123456';
GRANT ALL PRIVILEGES ON DATABASE netbox TO netbox;
```
> Không sử dụng mật khẩu từ ví dụ. Chọn một mật khẩu mạnh, ngẫu nhiên để đảm bảo an toàn

<h3>Kiểm tra trạng thái dịch vụ</h3>

Đăng nhập bằng user và mật khẩu đã tạo
```
$ psql --username netbox --password --host localhost netbox
Password for user netbox: 
psql (12.5 (Ubuntu 12.5-0ubuntu0.20.04.1))
SSL connection (protocol: TLSv1.3, cipher: TLS_AES_256_GCM_SHA384, bits: 256, compression: off)
Type "help" for help.

netbox=> \conninfo
You are connected to database "netbox" as user "netbox" on host "localhost" (address "127.0.0.1") at port "5432".
SSL connection (protocol: TLSv1.3, cipher: TLS_AES_256_GCM_SHA384, bits: 256, compression: off)
netbox=> \q
```

Trong đó: 
- Thay thế `localhost` bằng máy chủ cơ sở dữ liệu nếu sử dụng cơ sở dữ liệu từ xa
- Nhập `\conninfo` để xác nhận kết nối
- Nhập `\q` để thoát

## 2. Cài đặt Redis

>Redis là một kho lưu trữ key-value trong bộ nhớ mà NetBox sử dụng để lưu vào bộ nhớ đệm và queuing.

Lệnh cài đặt:
```
sudo apt install -y redis-server
```

Kiểm tra phiên bản đã cài:
```
redis-server -v
```

> Có thể sửa đổi cấu hình Redis tại `/etc/redis.conf` hoặc `/etc/redis/redis.conf`, thường để cấu hình mặc định.

Kiểm tra trạng thái dịch vụ
```
redis-cli ping
```
KQ: PONG là thành công

## 3. Cài đặt NetBox

Cài tất cả các gói yêu cầu và phụ thuộc:
```
sudo apt install -y python3 python3-pip python3-venv python3-dev build-essential libxml2-dev libxslt1-dev libffi-dev libpq-dev libssl-dev zlib1g-dev
```

Kiểm tra phiên bản cài đặt > 3.8:
```
python3 -V
```

<h3> Tải xuống NetBox </h3>

> Sử dụng thư mục `/opt/netbox` làm thư mục gốc

Tải xuống bản phát hành:
```
sudo wget https://github.com/netbox-community/netbox/archive/v3.0.0.tar.gz
sudo tar -xzf v3.0.0.tar.gz -C /opt
cd /opt/
mv netbox-3.0.0/ netbox
cd /opt/netbox/
```

Tạo người dùng
```
sudo adduser --system --group netbox
sudo chown --recursive netbox /opt/netbox/netbox/media/
```

Tạo tệp cấu hình cục bộ:
```
cd /opt/netbox/netbox/netbox/
sudo cp configuration.example.py configuration.py
```

Sửa tệp `configuration.py`:
```
sudo vi configuration.py
```

Các thông số cần sửa:

- ALLOWED_HOSTS:
  - Tên và địa chỉ IP máy chủ để truy cập máy chủ (Chỉ định ít nhất 1 tên hoặc địa chỉ IP)
    ```
    ALLOWED_HOSTS = ['netbox.cong.com','192.168.10.128']
    ```
  - Nếu chưa có
    ```
    ALLOWED_HOSTS = ['*']
    ```
- DATABASE
```
DATABASE = {
    'NAME': 'netbox',               # Database name
    'USER': 'netbox',               # PostgreSQL username
    'PASSWORD': '123456', # PostgreSQL password
    'HOST': 'localhost',            # Database server
    'PORT': '',                     # Database port (leave blank for default)
    'CONN_MAX_AGE': 300,            # Max database connection age (seconds)
}
```
> Nếu dịch vụ đang chạy từ xa, cần cập nhật các thông số: `HOST` và `POST` tương ứng
 
- REDIS
```
REDIS = {
    'tasks': {
        'HOST': 'localhost',      # Redis server
        'PORT': 6379,             # Redis port
        'PASSWORD': '',           # Redis password (optional)
        'DATABASE': 0,            # Database ID
        'SSL': False,             # Use SSL (optional)
    },
    'caching': {
        'HOST': 'localhost',
        'PORT': 6379,
        'PASSWORD': '',
        'DATABASE': 1,            # Unique ID for second database
        'SSL': False,
    }
}
```
- SECRET_KEY:

Tạo key:
```
python3 ../generate_secret_key.py
```

```
SECRET_KEY = '+9Z#eR8KAGIP5e^Q2LbPKEt+(rg)^-pSlHhyvmtiqLl5&7txig'
```

Lưu file lại

## 4. Chạy tập lệnh nâng cấp

Chúng ta sẽ chạy tập lệnh nâng cấp đóng gói ( upgrade.sh) để thực hiện các hành động sau:

- Tạo môi trường ảo Python
- Cài đặt tất cả các gói Python bắt buộc
- Chạy di chuyển giản đồ cơ sở dữ liệu
- Tạo tài liệu cục bộ (để sử dụng ngoại tuyến)
- Tổng hợp các tệp tài nguyên tĩnh trên đĩa

```
sudo /opt/netbox/upgrade.sh
```

## 5. Tạo Super User
NetBox không đi kèm với bất kỳ tài khoản người dùng nào được xác định trước. Vì vậy ta cần tạo một Super User (tài khoản quản trị) để có thể đăng nhập vào NetBox. 

- Đầu tiên, hãy nhập môi trường ảo Python được tạo bởi tập lệnh nâng cấp:
```
source /opt/netbox/venv/bin/activate
```

Chúng ta sẽ tạo một tài khoản superuser bằng `createsuperuser` lệnh quản lý Django (qua manage.py). (Địa chỉ email cho người dùng không bắt buộc)

```
cd /opt/netbox/netbox
python3 manage.py createsuperuser
```


## 6. Kiểm tra ứng dụng

Chạy máy chủ NetBox để có thể vào từ web:

```
cd /opt/netbox/netbox
source /opt/netbox/venv/bin/activate
python3 manage.py runserver 0.0.0.0:8000 --insecure
```

Thành công:
```
Performing system checks...

System check identified no issues (0 silenced).
August 16, 2022 - 10:03:21
Django version 3.2.6, using settings 'netbox.settings'
Starting development server at http://0.0.0.0:8000/
Quit the server with CONTROL-C.
```

Sau đó, trên giao diện web truy cập địa chỉ http://ip_netbox:8000

# Tài liệu tham khảo

1. https://docs.netbox.dev/en/stable/installation/
