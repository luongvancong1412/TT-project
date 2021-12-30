# [Bash Shell] Script tự động tạo 100 tệp .txt

## 1. Script tự động tạo tệp
Đoạn script sẽ thực hiện công việc tạo tệp từ 1 đến 100 trên Centos 7 trong đó mỗi tệp ghi số thứ tự tệp và thời gian tạo tệp (hiển thị đến mili giây)

Tạo 1 script backup có đường dẫn: **/scripts/createfile.sh**

```
#! /bin/bash
for name in {1..100}; do
	touch "cong_$name.txt"
	echo $name >> "cong_$name.txt"
	date +"%H:%M:%S.%3N" >> "cong_$name.txt"
done
```

Trong đó:
- `#! /bin/bash` được gọi là shebang, nó cho shell biết tập lệnh sẽ được biên dịch và chạy bởi bash shell.
- `@name` là số thứ tự của tệp và giá trị hiện tại của vòng for
- `{1..100}` được hiểu thành "1 2 3 4 ... 99 100"
- `touch` dùng để tạo tệp
- `echo $name > "cong_$name.txt"` : lệnh này sẽ nối giá trị của tham số `$name` hiện tại vào tệp `cong_@name.txt`
- `date +"%H:%M:%S.%3N"` hiển thị thời gian hiện tại đến mili giây.

## 2. Phân quyền cho script
Sử dụng lệnh:
```
chmod +x /scripts/createfile.sh
```
## 3. Chạy script
Chạy script bằng lệnh sau
```
cd /scripts
bash createfile.sh
```

Output:
```
[root@conglv scripts]# ls
cong_100.txt  cong_16.txt  cong_22.txt  cong_29.txt  cong_35.txt  cong_41.txt  cong_48.txt  cong_54.txt  cong_60.txt  cong_67.txt  cong_73.txt  cong_7.txt   cong_86.txt  cong_92.txt  cong_99.txt
cong_10.txt   cong_17.txt  cong_23.txt  cong_2.txt   cong_36.txt  cong_42.txt  cong_49.txt  cong_55.txt  cong_61.txt  cong_68.txt  cong_74.txt  cong_80.txt  cong_87.txt  cong_93.txt  cong_9.txt
cong_11.txt   cong_18.txt  cong_24.txt  cong_30.txt  cong_37.txt  cong_43.txt  cong_4.txt   cong_56.txt  cong_62.txt  cong_69.txt  cong_75.txt  cong_81.txt  cong_88.txt  cong_94.txt  createfile.sh
cong_12.txt   cong_19.txt  cong_25.txt  cong_31.txt  cong_38.txt  cong_44.txt  cong_50.txt  cong_57.txt  cong_63.txt  cong_6.txt   cong_76.txt  cong_82.txt  cong_89.txt  cong_95.txt
cong_13.txt   cong_1.txt   cong_26.txt  cong_32.txt  cong_39.txt  cong_45.txt  cong_51.txt  cong_58.txt  cong_64.txt  cong_70.txt  cong_77.txt  cong_83.txt  cong_8.txt   cong_96.txt
cong_14.txt   cong_20.txt  cong_27.txt  cong_33.txt  cong_3.txt   cong_46.txt  cong_52.txt  cong_59.txt  cong_65.txt  cong_71.txt  cong_78.txt  cong_84.txt  cong_90.txt  cong_97.txt
cong_15.txt   cong_21.txt  cong_28.txt  cong_34.txt  cong_40.txt  cong_47.txt  cong_53.txt  cong_5.txt   cong_66.txt  cong_72.txt  cong_79.txt  cong_85.txt  cong_91.txt  cong_98.txt
[root@conglv scripts]# cat cong_29.txt
29
22:49:43.836
```