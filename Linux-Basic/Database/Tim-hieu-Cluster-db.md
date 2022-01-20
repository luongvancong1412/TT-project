# Tìm hiểu Cluster DB

- [Tìm hiểu Cluster DB](#tìm-hiểu-cluster-db)
  - [I. Tổng quan về Cluster](#i-tổng-quan-về-cluster)
    - [1. Khái niệm](#1-khái-niệm)
    - [2. Tính năng](#2-tính-năng)
    - [3. Các chế độ hoạt động chính:](#3-các-chế-độ-hoạt-động-chính)
      - [3.1 Active - Active (Load balancing)](#31-active---active-load-balancing)
      - [3.2 Active - Passive (High availability)](#32-active---passive-high-availability)
  - [II. Ứng dụng: Cluster DB](#ii-ứng-dụng-cluster-db)
    - [1. Khái niệm Database Clustering](#1-khái-niệm-database-clustering)
    - [2. Ưu điểm](#2-ưu-điểm)
      - [2.1. Khả năng chịu lỗi](#21-khả-năng-chịu-lỗi)
      - [2.2. Cân bằng tải](#22-cân-bằng-tải)
  - [III. Lab: Cài đặt MariaDB Galera Cluster](#iii-lab-cài-đặt-mariadb-galera-cluster)
    - [1. Mô hình mạng](#1-mô-hình-mạng)
    - [2. Các bước thực hiện](#2-các-bước-thực-hiện)
      - [2.1 Chuẩn bị](#21-chuẩn-bị)
      - [2.2 Cài đặt Mariadb 10.2](#22-cài-đặt-mariadb-102)
      - [2.3 Cấu hình Galera](#23-cấu-hình-galera)
      - [2.4 Khởi động Cluster](#24-khởi-động-cluster)
      - [2.5 Kiểm tra cluster](#25-kiểm-tra-cluster)
- [Tài liệu tham khảo](#tài-liệu-tham-khảo)

## I. Tổng quan về Cluster
### 1. Khái niệm
- Cluster là một nhóm các máy chủ và tài nguyên khác hoạt động giống như một hệ thống duy nhất.
  - Cluster là kiến trúc nâng cao khả năng sẵn sàng cho các hệ thống dịch vụ. 
  - Hệ thống Cluster cho phép nhiều máy chủ chạy kết hợp, đồng bộ với nhau. 
  - Hệ thống Cluster nâng cao khả năng chịu lỗi của hệ thống, tăng cấp độ tin cậy, tăng tính đảm bảo, nâng cao khả năng mở rộng cho hệ thống. 
- Trong trường hợp có lỗi xảy ra, các dịch vụ bên trong Cluster sẽ tự động loại trừ lỗi, cố gắng khôi phục, duy trì tính ổn định, tính sẵn sàng của dịch vụ
- Cluster thường được tìm thấy ở các hệ thống thanh toán trực tuyến, ngân hàng, các cơ sở dữ liệu, hệ thống lưu trữ ..
### 2. Tính năng
- **Cân bằng tải của cụm (Load Balancing)**: Các node bên trong cluster hoạt động song song, chia sẻ các tác vụ để năng cao hiệu năng.
- **Tính sẵn sàng cao (High availability)**: Các tài nguyên bên trong cluster luôn sẵn sàng xử lý yêu cầu, ngay cả khi có vấn đề xảy ra với các thành phần bên trong (hardware, software).
- **Khả năng mở rộng (scalability)**: Khi tài nguyên có thể sử dụng của hệ thống tới giới hạn, ta có thể dễ dàng bổ sung thêm tài nguyên vào cluster bằng các bổ sung thêm các node.
- **Độ tin cậy (reliability)**: Hệ thống Cluster giảm thiểu tần số lỗi có thể xảy ra, giảm thiểu các vấn đề dẫn tới ngừng hoạt động của hệ thống.
### 3. Các chế độ hoạt động chính:
#### 3.1 Active - Active (Load balancing)
- Cần ít nhất 2 node, cả 2 node chạy đồng thời xử lý cùng 1 loại dịch vụ. 
- Mục đích chính của Active Active Cluster là tối ưu hóa cho hoạt động cân bằng tải (Load balancing). 
- Hoạt động cân bằng tải (Load balancing) sẽ phân phối các tác vụ hệ thống tới tất cả các node bên trong cluster, tránh tình trạng các node xử lý tác vụ không cân bằng dẫn tới tình trạng quả tải. Bên cạnh đó, Active-Active Cluster nâng cao thông lượng (thoughput) và thời gian phản hổi

- Khuyển cáo cho chế độ Active Active Cluster là các node trong cụm cần được cấu hình giống nhau tránh tình trạng phân mảnh cụm.

#### 3.2 Active - Passive (High availability)
- A high availability cluster là 1 nhóm các máy chủ hoạt động như 1 hệ thống duy nhất và cung cấp thời gian hoạt động liên tục.
- Cần ít nhất 2 node, tuy nhiên không phải tất cả các node đều sẵn sàng xử lý yêu cầu. VD: Nếu có 2 node thì 1 node sẽ chạy ở chế độ Active, node còn lại sẽ chạy ở chế độ passive hoặc standby.
- Passive Node sẽ hoạt động như 1 bản backup của Active Node. Trong trường hợp Active Node xảy ra vấn đề, Passive Node sẽ chuyển trạng thái thành active, tiếp quản xử lý các yêu cầu.

- Ưu điểm:
  - Hệ thống hoạt động liên tục
- Nhược điểm:
  - Bỏ tiền mua 2 máy nhưng chỉ đang sử dụng 1 máy chủ mà không sử dụng tài nguyên máy chủ thứ 2 mặc dù máy 2 vẫn hoạt động
## II. Ứng dụng: Cluster DB
### 1. Khái niệm Database Clustering
- Phân cụm cơ sở dữ liệu đề cập đến khả năng của một số máy chủ hoặc phiên bản kết nối với một cơ sở dữ liệu duy nhất.

- Một cá thể là tập hợp bộ nhớ và các quy trình tương tác với cơ sở dữ liệu, là tập hợp các tệp vật lý thực sự lưu trữ dữ liệu.


### 2. Ưu điểm
Phân cụm cơ sở dữ liệu cung cấp hai ưu điểm chính, đặc biệt là trong môi trường cơ sở dữ liệu khối lượng lớn:

#### 2.1. Khả năng chịu lỗi
Vì có nhiều hơn một máy chủ hoặc phiên bản để người dùng kết nối, việc phân cụm cung cấp một giải pháp thay thế, trong trường hợp máy chủ riêng lẻ bị lỗi.

#### 2.2. Cân bằng tải
Tính năng phân cụm thường được thiết lập để cho phép người dùng được tự động phân bổ cho máy chủ có tải ít nhất.

Phân cụm cơ sở dữ liệu có các dạng khác nhau, tùy thuộc vào cách dữ liệu được lưu trữ và phân bổ tài nguyên.

## III. Lab: Cài đặt MariaDB Galera Cluster
- MariaDB Galera Cluster là cơ chế đồng bộ dữ liệu cho multi-master MariaDB. Phục vụ tính sẵn sàng cao cho MariaDB với chế độ Active-Active ( Có thể đồng thời đọc ghi trên tất cả các node MariaDB thuộc Garela Cluster.
- Sử dụng galera cluster, application có thể read/write trên bất cứ node nào. Một node có thể được thêm vào cluster cũng như gỡ ra khỏi cluster mà không có downtime dịch vụ, cách thức cũng đơn giản.
- Bản thân các database như mariadb, percona xtradb không có tính năng multi master được tích hợp sẵn bên trong.Các database này sẽ sử dụng một galera replication plugin để sử dụng tính năng multi master do galera cluster cung cấp (wsrep api).

**Tính năng**
- Sao chép đồng bộ
- Cấu trúc liên kết Active-active multi-master tăng cao hiệu suất
- Đọc và ghi vào bất kỳ node server
- Kiểm soát các node tự động, các node lỗi sẽ được được gỡ khỏi cluster
- Thêm node tự động
### 1. Mô hình mạng

![](./../image/cluster-mhm-ok.png)

### 2. Các bước thực hiện
#### 2.1 Chuẩn bị

**Tại node 1**

Cấu hình Hostname
```
hostnamectl set-hostname node1
echo "192.168.30.200 node1" >> /etc/hosts
echo "192.168.30.250 node2" >> /etc/hosts
```

Cài đặt gói
```
yum install epel-release -y
yum update -y
```

Tắt SELinux, Firewalld
```
sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/sysconfig/selinux
sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config
systemctl stop firewalld
systemctl disable firewalld
init 6
```

**Tại node 2**

Cấu hình Hostname
```
hostnamectl set-hostname node2
echo "192.168.30.200 node1" >> /etc/hosts
echo "192.168.30.250 node2" >> /etc/hosts
```

Cài đặt gói
```
yum install epel-release -y
yum update -y
```

Tắt SELinux, Firewalld
```
sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/sysconfig/selinux
sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config
systemctl stop firewalld
systemctl disable firewalld
init 6
```

#### 2.2 Cài đặt Mariadb 10.2
> Thực hiện tương tự trên tất cả các node

Thêm repo
```
echo '[mariadb]
name = MariaDB
baseurl = http://yum.mariadb.org/10.2/centos7-amd64
gpgkey=https://yum.mariadb.org/RPM-GPG-KEY-MariaDB
gpgcheck=1' >> /etc/yum.repos.d/MariaDB.repo
yum -y update
```

Cài đặt Mariadb, galera, rsync
```
yum install -y mariadb mariadb-server

yum install -y galera rsync

systemctl stop mariadb
systemctl disable mariadb
```

Cấu hình Log
```
cp /etc/my.cnf /etc/my.cnf.org

cat > /etc/my.cnf << EOF
[mysqld]
slow_query_log                  = 1
slow_query_log_file             = /var/log/mariadb/slow.log
long_query_time                 = 5
log_error                       = /var/log/mariadb/error.log
general_log_file                = /var/log/mariadb/mysql.log
general_log                     = 1

[client-server]
!includedir /etc/my.cnf.d
EOF

mkdir -p /var/log/mariadb/
chown -R mysql. /var/log/mariadb/
```

#### 2.3 Cấu hình Galera
Tại node 1:
```
cp /etc/my.cnf.d/server.cnf /etc/my.cnf.d/server.cnf.bak

cat > /etc/my.cnf.d/server.cnf << EOF
[server]
[mysqld]

[galera]
wsrep_on=ON
wsrep_provider=/usr/lib64/galera/libgalera_smm.so
#add your node ips here
wsrep_cluster_address="gcomm://192.168.30.200,192.168.30.250"
binlog_format=row
default_storage_engine=InnoDB
innodb_autoinc_lock_mode=2
#Cluster name
wsrep_cluster_name="cong_cluster"
# this server ip, change for each server
wsrep_node_address="192.168.30.200"
# this server name, change for each server
wsrep_node_name="node1"
wsrep_sst_method=rsync
[embedded]
[mariadb]
[mariadb-10.2]
EOF
```

Tại node 2
```
cp /etc/my.cnf.d/server.cnf /etc/my.cnf.d/server.cnf.bak

cat > /etc/my.cnf.d/server.cnf << EOF
[server]
[mysqld]

[galera]
wsrep_on=ON
wsrep_provider=/usr/lib64/galera/libgalera_smm.so
#add your node ips here
wsrep_cluster_address="gcomm://192.168.30.200,192.168.30.250"
binlog_format=row
default_storage_engine=InnoDB
innodb_autoinc_lock_mode=2
#Cluster name
wsrep_cluster_name="cong_cluster"
# this server ip, change for each server
wsrep_node_address="192.168.30.250"
# this server name, change for each server
wsrep_node_name="node2"
wsrep_sst_method=rsync
[embedded]
[mariadb]
[mariadb-10.2]
EOF
```
Trong đó:
- wsrep_cluster_address="gcomm://192.168.30.200,192.168.30.250" : danh sách các node thuộc Cluster.
- wsrep_cluster_name="cong_cluster": tên của Cluster
- wsrep_node_address="192.168.30.250" địa chỉ IP của node đang thực hiện
- wsrep_node_name="node2" : tên node
#### 2.4 Khởi động Cluster

Ở đây, dùng node1 làm node khởi tạo Galera cluster ( Tức là các node khác sẽ đồng bộ dữ liệu từ node1 )

**Thực hiện trên node1**
```
galera_new_cluster
systemctl enable mariadb
```

**Thực hiện join node 2 và các node khác nếu có vào cụm:**
```
systemctl start mariadb
systemctl enable mariadb
```
#### 2.5 Kiểm tra cluster
Kiểm tra số node thuộc cluster
```
mysql -u root -e "SHOW STATUS LIKE 'wsrep_cluster_size'"
```

Kết quả
```
[root@localhost ~]# mysql -u root -e "SHOW STATUS LIKE 'wsrep_cluster_size'"
+--------------------+-------+
| Variable_name      | Value |
+--------------------+-------+
| wsrep_cluster_size | 2     |
+--------------------+-------+
```

Kiểm tra các thành viên thuộc cluster
```
[root@moodle01 ~]# mysql -u root -e "SHOW STATUS LIKE 'wsrep_incoming_addresses'"
```

Kết quả:
```
[root@localhost ~]# mysql -u root -e "SHOW STATUS LIKE 'wsrep_incoming_addresses'"
+--------------------------+-----------------------------------------+
| Variable_name            | Value                                   |
+--------------------------+-----------------------------------------+
| wsrep_incoming_addresses | 192.168.30.250:3306,192.168.30.200:3306 |
+--------------------------+-----------------------------------------+
```
# Tài liệu tham khảo

1. https://blog.cloud365.vn/linux/tong-quan-ve-cluster-p1/
2. https://www.techopedia.com/definition/17/database-clustering
3. https://dev.mysql.com/doc/refman/8.0/en/mysql-cluster-installation.html
4. https://viblo.asia/p/mysql-cluster-la-cai-gi-4P856QmLlY3
5. https://clusterlabs.org/pacemaker/doc/deprecated/en-US/Pacemaker/1.1/pdf/Clusters_from_Scratch/Pacemaker-1.1-Clusters_from_Scratch-en-US.pdf
6. https://www.youtube.com/watch?v=8BBDxzJL6fY