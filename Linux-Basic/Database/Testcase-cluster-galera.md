# Testing a Cluster

- [Testing a Cluster](#testing-a-cluster)
  - [1. Kiểm tra đồng bộ dữ liệu](#1-kiểm-tra-đồng-bộ-dữ-liệu)

## 1. Kiểm tra đồng bộ dữ liệu
Tạo 1 bảng và chèn dữ liệu vào đó. Sử dụng **node1** để nhập vào các câu lệnh sau
- Tạo database:
```
create database vidu;
```
- Tạo bảng:

```
use vidu;
CREATE TABLE IF NOT EXISTS sinhvien(
    sv_id INT(11) NOT NULL AUTO_INCREMENT,
    sv_name VARCHAR(255) NOT NULL,
    sv_description  VARCHAR(500),
    CONSTRAINT pk_sinhvien PRIMARY KEY(sv_id)
) ENGINE = INNODB;
```
Các câu lệnh này sẽ tạo CSDL **vidu** và bảng **sinhvien** bên trong nó.
Sau khi thực hiện việc này, đăng nhập **node2** và kiểm tra CSDL đã được đồng bộ chưa.
```
mysql -u root

MariaDB [(none)]> show databases;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| performance_schema |
| vidu               |
+--------------------
4 rows in set (0.09 sec)

MariaDB [(none)]> use vidu;
Reading table information for completion of table and column names
You can turn off this feature to get a quicker startup with -A

Database changed

MariaDB [vidu]> show tables;
+----------------+
| Tables_in_vidu |
+----------------+
| sinhvien       |
+----------------+
1 row in set (0.00 sec)
```
Kết quả chỉ ra rằng dữ liệu được nhập vào **node2** đã được sao chép vào **node2**. Tiếp tục insert vào bảng **sinhvien** trên **node2**.
- Insert vào bảng:
```
MariaDB [vidu]> INSERT INTO sinhvien(sv_name, sv_description)
    -> VALUES('Mr Cong', 'Luong Van Cong');
Query OK, 1 row affected (0.01 sec)

MariaDB [vidu]> INSERT INTO sinhvien(sv_name, sv_description)
    -> VALUES('Mr Tuan', 'Nguyen Ngoc Tuan');
Query OK, 1 row affected (0.01 sec)
```
- Đăng nhập trên **node3** kiểm tra dữ liệu nhập trên **node2**:
```
MariaDB [vidu]> SELECT * FROM sinhvien;
+-------+---------+------------------+
| sv_id | sv_name | sv_description   |
+-------+---------+------------------+
|     3 | Mr Cong | Luong Van Cong   |
|     6 | Mr Tuan | Nguyen Ngoc Tuan |
+-------+---------+------------------+
2 rows in set (0.00 sec)

```
Kết quả dữ liệu đã được đồng bộ sang **node3**. 
Tiến hành ngắt kết nối **node3**. Sau đó tiếp tục insert vào bảng **sinhvien** trên **node2**
```
MariaDB [vidu]> INSERT INTO sinhvien(sv_name, sv_description)
    -> VALUES('Mr Hieu', 'Do Minh Hieu');
Query OK, 1 row affected (0.00 sec)

MariaDB [vidu]> INSERT INTO sinhvien(sv_name, sv_description)
    -> VALUES('Mr C', 'Nguyen Van C');
Query OK, 1 row affected (0.00 sec)
```

- Kết quả sau khi nhập:
```
MariaDB [vidu]> SELECT * FROM sinhvien;
+-------+---------+------------------+
| sv_id | sv_name | sv_description   |
+-------+---------+------------------+
|     3 | Mr Cong | Luong Van Cong   |
|     6 | Mr Tuan | Nguyen Ngoc Tuan |
|    10 | Mr Hieu | Do Minh Hieu     |
|    12 | Mr C    | Nguyen Van C     |
+-------+---------+------------------+
4 rows in set (0.00 sec)

```

- Tiến hành bật lại **node3** vừa tắt, kiểm tra:
```
[root@node1 ~]# mysql -u root -p
Enter password:
Welcome to the MariaDB monitor.  Commands end with ; or \g.
Your MariaDB connection id is 10
Server version: 10.2.41-MariaDB-log MariaDB Server

Copyright (c) 2000, 2018, Oracle, MariaDB Corporation Ab and others.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

MariaDB [(none)]> show databases;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| performance_schema |
| vidu               |
+--------------------+
4 rows in set (0.01 sec)

MariaDB [(none)]> use vidu;
Reading table information for completion of table and column names
You can turn off this feature to get a quicker startup with -A

Database changed
MariaDB [vidu]> show tables;
+----------------+
| Tables_in_vidu |
+----------------+
| sinhvien       |
+----------------+
1 row in set (0.00 sec)

MariaDB [vidu]> SELECT * FROM sinhvien;
+-------+---------+------------------+
| sv_id | sv_name | sv_description   |
+-------+---------+------------------+
|     3 | Mr Cong | Luong Van Cong   |
|     6 | Mr Tuan | Nguyen Ngoc Tuan |
|    10 | Mr Hieu | Do Minh Hieu     |
|    12 | Mr C    | Nguyen Van C     |
+-------+---------+------------------+
4 rows in set (0.00 sec)
```
Kết quả : Trên **node3** dữ liệu đã được đồng bộ.