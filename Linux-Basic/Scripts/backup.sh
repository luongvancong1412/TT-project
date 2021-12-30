#! /bin/bash

thoigian=$(date +"%H%M%S-%d%m%Y")
DBname=quanly
dbuser=admindb
pass=123456

cd /root/Taofile
mysqldump -u $dbuser -p$pass $DBname > $DBname-$thoigian.sql