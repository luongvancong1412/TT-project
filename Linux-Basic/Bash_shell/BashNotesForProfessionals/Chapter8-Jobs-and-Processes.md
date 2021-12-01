# Chapter 8: Jobs and Processes (Công việc và quy trình)

- [Chapter 8: Jobs and Processes (Công việc và quy trình)](#chapter-8-jobs-and-processes-công-việc-và-quy-trình)
  - [8.1 Job handling - Xử lý công việc](#81-job-handling---xử-lý-công-việc)
  - [8.2: Check which process running on specific port - Kiểm tra quá trình nào đang chạy trên cổng cụ thể](#82-check-which-process-running-on-specific-port---kiểm-tra-quá-trình-nào-đang-chạy-trên-cổng-cụ-thể)
  - [8.3: Disowning background job - Từ chối công việc nền](#83-disowning-background-job---từ-chối-công-việc-nền)
  - [8.4: List Current Jobs - Liệt kê công việc hiện tại](#84-list-current-jobs---liệt-kê-công-việc-hiện-tại)
  - [8.5: Finding information about a running process - Tìm kiếm thông tin về một quy trình đang chạy](#85-finding-information-about-a-running-process---tìm-kiếm-thông-tin-về-một-quy-trình-đang-chạy)
  - [8.6: List all processes -  Liệt kê tất cả các quy trình](#86-list-all-processes----liệt-kê-tất-cả-các-quy-trình)

## 8.1 Job handling - Xử lý công việc

**Creating jobs**
Để tạo một công việc, chỉ cần thêm một & sau lệnh:

Bạn cũng có thể biến quá trình đang chạy thành một công việc bằng cách nhấn Ctrl + z:

**Bối cảnh và tiền cảnh một quá trình**
Để đưa Quy trình lên nền trước, lệnh fg được sử dụng cùng với %
```
$ sleep 10 &
[1] 20024
$ fg %1
sleep 10
```

Bây giờ bạn có thể tương tác với quy trình. Để đưa nó trở lại nền, bạn có thể sử dụng lệnh bg . Bởi vìphiên đầu cuối bị chiếm, trước tiên bạn cần dừng quá trình bằng cách nhấn Ctrl + z.
```
$ sleep 10
^Z
[1]+ Stopped sleep 10
$ bg %1
[1]+ sleep 10 &
```

Do sự lười biếng của một số Lập trình viên, tất cả các lệnh này cũng hoạt động với một % duy nhất nếu chỉ có mộtquy trình, hoặc quy trình đầu tiên trong danh sách. Ví dụ:

```
$ sleep 10 &
[1] 20024
$ fg % # to bring a process to foreground 'fg %' is also working.
sleep 10
```
Hoặc
```
$ % # laziness knows no boundaries, '%' is also working.
sleep 10
```

Ngoài ra, chỉ cần nhập fg hoặc bg mà không có bất kỳ đối số nào sẽ xử lý công việc cuối cùng:

```
$ sleep 20 &
$ sleep 10 &
$ fg
sleep 10
^C
$ fg
sleep 2
```

**Killing running jobs**
```
$ sleep 10 &
[1] 20024
$ kill %1
[1]+ Terminated     sleep 10
```

Quá trình ngủ chạy trong nền với id quy trình (pid) 20024 và công việc số 1 . Để tham khảoquá trình này, bạn có thể sử dụng pid hoặc số công việc. Nếu bạn sử dụng số công việc, bạn phải bắt đầu bằng % . Cáctín hiệu tiêu diệt mặc định được gửi bởi tiêu diệt là SIGTERM , cho phép tiến trình đích thoát ra một cách duyên dáng.

Một số tín hiệu tiêu diệt phổ biến được hiển thị bên dưới. Để xem danh sách đầy đủ, hãy chạy kill -l 


Signal name| Signal value |Effect
|---|---|---|
SIGHUP |1| Hangup
SIGINT |2| Interrupt from keyboard
SIGKILL |9 |Kill signal
SIGTERM |15 |Termination signal|

**Bắt đầu và kết thúc các quy trình cụ thể**

Có lẽ cách dễ nhất để giết một tiến trình đang chạy là chọn nó thông qua tên tiến trình như sau,ví dụ sử dụng lệnh pkill như
```
pkill -f test.py
```
(hoặc) một cách chống đánh lừa khác bằng cách sử dụng pgrep để tìm kiếm id quy trình thực tế

```
kill $(pgrep -f 'python test.py')
```

Kết quả tương tự có thể đạt được bằng cách sử dụng grep over ps -ef | grep name_of_process sau đó giết quá trìnhđược liên kết với pid kết quả (id quy trình). Việc chọn một quy trình sử dụng tên của nó là thuận lợi trong quá trình thử nghiệmmôi trường nhưng có thể thực sự nguy hiểm khi kịch bản được sử dụng trong sản xuất: hầu như không thể chắc chắnrằng tên sẽ phù hợp với quá trình bạn thực sự muốn giết. Trong những trường hợp đó, cách tiếp cận sau đây thực sự lànhiều an toàn.
Bắt đầu tập lệnh cuối cùng sẽ bị giết bằng cách tiếp cận sau. Giả sử rằng lệnh bạn muốnthực hiện và cuối cùng giết là python test.p

```
#!/bin/bash
if [[ ! -e /tmp/test.py.pid ]]; then # Check if the file already exists
python test.py & #+and if so do not run another process.
echo $! > /tmp/test.py.pid
else
echo -n "ERROR: The process is already running with pid "
cat /tmp/test.py.pid
echo
fi
```

Thao tác này sẽ tạo một tệp trong thư mục / tmp có chứa pid của quá trình python test.py. Nếu tệp đã cótồn tại, chúng tôi giả định rằng lệnh đã chạy và tập lệnh trả về lỗi.

Sau đó, khi bạn muốn giết nó, hãy sử dụng tập lệnh sau:

```
#!/bin/bash
if [[ -e /tmp/test.py.pid ]]; then # If the file do not exists, then the
kill `cat /tmp/test.py.pid` #+the process is not running. Useless
rm /tmp/test.py.pid #+trying to kill it.
else
echo "test.py is not running"
fi
```

điều đó sẽ giết chết chính xác quá trình được liên kết với lệnh của bạn mà không cần dựa vào bất kỳ thông tin dễ thay đổi nào (nhưchuỗi dùng để chạy lệnh). Ngay cả trong trường hợp này nếu tệp không tồn tại, tập lệnh giả định rằng bạn muốn hủy mộttiến trình không chạy.
Ví dụ cuối cùng này có thể được cải thiện dễ dàng để chạy cùng một lệnh nhiều lần (thêm vào tệp pidthay vì ghi đè lên nó, chẳng hạn) và để quản lý các trường hợp quá trình chết trước khi bị kill.

## 8.2: Check which process running on specific port - Kiểm tra quá trình nào đang chạy trên cổng cụ thể

Để kiểm tra quá trình nào đang chạy trên cổng 8080
```
lsof -i :8080
```

## 8.3: Disowning background job - Từ chối công việc nền

```
$ gzip extremelylargefile.txt &
$ bg
$ disown %1
```
Điều này cho phép một quá trình chạy dài tiếp tục khi trình bao của bạn (thiết bị đầu cuối, ssh, v.v.) bị đóng.

## 8.4: List Current Jobs - Liệt kê công việc hiện tại

```
$ tail -f /var/log/syslog > log.txt
[1]+ Stopped tail -f /var/log/syslog > log.txt
$ sleep 10 &
$ jobs
[1]+ Stopped tail -f /var/log/syslog > log.txt
[2]- Running sleep 10 &
```

## 8.5: Finding information about a running process - Tìm kiếm thông tin về một quy trình đang chạy

```
ps aux | grep <search-term> shows processes matching search-term
```

```
root@server7:~# ps aux | grep nginx
root 315 0.0 0.3 144392 1020 ? Ss May28 0:00 nginx: master process
/usr/sbin/nginx
www-data 5647 0.0 1.1 145124 3048 ? S Jul18 2:53 nginx: worker process
www-data 5648 0.0 0.1 144392 376 ? S Jul18 0:00 nginx: cache manager process
root 13134 0.0 0.3 4960 920 pts/0 S+ 14:33 0:00 grep --color=auto nginx
```

Ở đây, cột thứ hai là id quy trình. Ví dụ: nếu bạn muốn hủy tiến trình nginx, bạn có thể sử dụng lệnh kill 5647 . Luôn được khuyến khích sử dụng lệnh kill với SIGTERM thay vì SIGKILL.

## 8.6: List all processes -  Liệt kê tất cả các quy trình
Có hai cách phổ biến để liệt kê tất cả các quy trình trên một hệ thống. Tuy nhiên, cả hai đều liệt kê tất cả các quy trình được chạy bởi tất cả người dùngchúng khác nhau về định dạng mà chúng xuất ra (lý do cho sự khác biệt là do lịch sử)

```
ps -ef # lists all processes
ps aux # lists all processes in alternative format (BSD)
```

Điều này có thể được sử dụng để kiểm tra xem một ứng dụng nhất định có đang chạy hay không. Ví dụ: để kiểm tra xem máy chủ SSH (sshd) có đang chạy hay không:

```
ps -ef | grep sshd
```