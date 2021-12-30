#! /bin/bash

#Các tham số sử dụng
TIME=$(date +"%H%M%S-%d%m%Y")
DBNAME=quanly
DBUSER=admindb
PASSWD=123456

#Lệnh backup
cd /backup
mysqldump -u $DBUSER -p$PASSWD $DBNAME > $DBNAME-$TIME.sql