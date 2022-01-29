

## Ping and traceroute for basic network troubleshooting

Các lệnh ping và traceroute để thực hiện các tác vụ gỡ lỗi mạng cơ bản từ một máy chủ.

Ví dụ: sử dụng phương pháp down-up để khắc phục sự cố kết nối với máy chủ từ xa:

1. Có thể Ping địa chỉ IP của máy không? - Để kiểm tra xem IP của máy có đúng không và interface có lên không. Một bài test layer-1 cơ bản. 
2. Có thể Ping 1 máy chủ khác trên cùng một mạng không? - Để test layer-2.
3. Có thể Ping gateway của mình không? - Để test layer-3 của local network.
4. Có thể Ping đến 1 mạng khác không? - Để kiểm tra xem việc định tuyến có hoạt động hay không, đồng thời có ý tưởng về tỷ lệ RTT và gói bị mất.
5. Sau đó, thực hiện traceroute để xem con đường sử dụng đến destination này? - để xem đường định tuyến và các bước nhảy tới đích này.

Để thay thế các bước 4 và 5 ở trên, chúng ta có thể sử dụng lệnh mtr.

## The mtr command: My TraceRoute

**My TraceRoute**, ban đầu có tên là **Matt's traceroute** (**MTR**) kết hợp các chức năng của **Ping** để đo độ trễ, jitter, mất gói và **traceroute** để xem đường dẫn và só bước nhảy giữa người gửi và điểm đến, trong cùng một tool. Nó cho phép bạn liên tục thăm dò 1 máy chủ từ xa và xem độ trễ, tỷ lệ gói bị mất và chập chờn thay đổi như thế nào theo thời gian.

NOte: MTR khả dụng cả trên Linux, Windows và Mac.

## Cách hoạt động

Giống như các công cụ traceroute khác, mtr dựa vào các gói ICMP Time Exceeded quay trở lại từ transit hops/routers bằng cách gửi các gói resquest ICMP Echo với trường TTL tăng 1 cho mỗi request. Sau đó, nó sử dụng các đặc điểm của câu trả lời (thời gian, chênh lệch thời gian giữa các gói, gói bị át hay không,v.v.) để xây dựng, thống kê đầu ra.

MTR cũng có chế độ UDP và TCP, gửi các gói UDP và TCP đến Destination mà chúng ta chọn, với trường TTL trong IP header tăng 1 cho mỗi thăm dò được gửi đến destination. Khi chế độ UDP or TCP được sử dụng, MTR dựa vào ICMP port unreachable packets khi đến đích.

## Basic use of mtr

### Default use
Lệnh mtr hiển thị hostnames trong interface và chạy cho đến khi nhập **q**

Ex:
```
mtr 8.8.8.8
```

### Display Numeric IP addresses

Sử dụng option **-n**, mtr hiển thị địa chỉ IP dạng số thay vì hostnames

```
mtr 8.8.8.8 -n
```

### Display hostnames and numeric IP addresses

Sử dụng option **-b** mtr hiển thị cả địa chỉ IP dạng số và hostnames.

```
mtr 8.8.8.8 -b
```

## More advanced use of mtr
### Report or report-wide mode


### Send more packets


### Send packets faster


### Change the fields of the report


## Using mtr for QoS debugging


### Measure the jitter


### Using TCP or UDP instead of ICMP echo


### Set the type of service field


### Extra: xml, json, csv, raw outputs