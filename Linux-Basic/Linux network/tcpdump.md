# TCPDUMP

## Giới thiệu

- Tcpdump là một công cụ bắt gói hoặc trình đánh giá và công cụ phổ biến nhất trên các bản phân phối Linux

## Basic

Nhập **ip link show up** để xem các giao diện hiện tại của hệ thống của bạn, ví dụ:
```
$ ip link show up
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1000
link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
2: enp0s3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP mode DEFAULT group default qlen 1000
link/ether 08:00:27:db:88:56 brd ff:ff:ff:ff:ff:ff
```


Sau đó, đối với ví dụ này, đây là cách bắt các gói từ giao diện Ethernet enp0s3:
```
$ sudo tcpdump -i enp0s3
```

Phương pháp khác là sử dụng tcpdump để lấy danh sách giao diện, với lệnh: tcpdump -D , điều này có thể hữu ích trên các hệ thống không có lệnh khác để liệt kê chúng:
```
$ sudo tcpdump -D
1.enp0s3 [Up, Running, Connected]
2.any (Pseudo-device that captures on all interfaces) [Up, Running]
3.lo [Up, Running, Loopback]
4.bluetooth-monitor (Bluetooth Linux Monitor) [Wireless]
5.nflog (Linux netfilter log (NFLOG) interface) [none]
6.nfqueue (Linux netfilter queue (NFQUEUE) interface) [none]
7.dbus-system (D-Bus system bus) [none]
8.dbus-session (D-Bus session bus) [none]
```

Sau đó, có thể sử dụng tên hoặc số giao diện, vẫn với đối số -i , như:
```
$ sudo tcpdump -i 1
tcpdump: verbose output suppressed, use -v[v]... for full protocol decode
listening on enp0s3, (...)
```

### Capture Packets and write to a file (-w /path/to/file) or read from a file (-r /path/to/file)

Tcpdump cũng có thể được chạy với cờ -w , làm cho nó lưu dữ liệu gói vào một tệp, để phân tích sau này. Ví dụ: để nắm bắt các gói từ một giao diện cụ thể và ghi nó vào một tệp (nên sử dụng phần mở rộng .pcap):
```
$ sudo tcpdump -w test.pcap
```

Sau đó, bạn có thể đọc tệp này bằng một ứng dụng như Wireshark hoặc cũng bằng tcpdump. Đối với điều này, chúng ta có thể sử dụng cờ -r , khiến tcpdump đọc từ tệp gói đã lưu thay vì đọc gói từ giao diện mạng:
```
$ sudo tcpdump -r test.pcap
```

### Capture Packets and write to multiple files (-w -C -W) in a “rotating” buffer
Tùy chọn filecount (-W) được sử dụng cùng với các tùy chọn file_size (-C) và ghi (-w) , cho phép ghi nhiều tệp với kích thước tối đa được xác định trước. Sau đó, khi kết thúc việc ghi tệp cuối cùng, tcpdump sẽ bắt đầu ghi đè lên các tệp từ đầu, tạo ra một bộ đệm 'xoay' gồm n tệp.

Hãy lấy một ví dụ bằng cách viết 10 tệp có dung lượng khoảng 1MByte mỗi tệp. “Xung quanh”, bởi vì các đơn vị của kích thước tệp là hàng triệu byte: 1'000'000 byte, không phải 1'048'576 byte:

```
$ sudo tcpdump -C 1 -W 10 -w test.pcap
```

### Capture Packets and write to multiple files, created every x time, with a timestamp into the filename (-G -w)

Dưới đây là ví dụ để tạo tệp chụp cứ sau 10 giây, do đó, 6 tệp chụp mỗi phút, vô thời hạn, với dấu thời gian Tháng - Ngày - Giờ - Phút - Giây vào tên tệp:

```
$ sudo tcpdump -G 10 -w test-%m-%d-%H-%M-%S.pcap
```
Trong trường hợp này, tùy chọn -G bằng 10 giây. Vì vậy, cứ sau 10 giây chúng ta sẽ có một tệp mới.

Xin lưu ý rằng nếu chúng tôi không chỉ định tùy chọn Tháng và Ngày, tcpdump sẽ ghi đè lên các tệp sau 24 giờ.

### Read from multiple files (-V /path/to/file)

Nó cũng có thể được chạy với cờ -V , làm cho nó đọc danh sách các tệp gói đã lưu. Trong mọi trường hợp, chỉ những gói phù hợp với biểu thức mới được xử lý bởi tcpdump.

Đối với điều này, trước tiên, bạn phải tạo một tệp phẳng bao gồm các tệp .pcap mà bạn muốn đọc. Ví dụ: nếu các tệp .pcap của tôi là: test.pcap0, test.pcap1, test.pcap2… test.pcap9. Tôi tạo một tệp .txt như sau:

```
test.pcap0 
test.pcap1 
test.pcap2 
test.pcap3 
test.pcap4 
test.pcap5 
test.pcap6 
test.pcap7 
test.pcap8 
test.pcap9
```

Và sau đó, tôi có thể đọc tất cả cùng một lúc với:
```
$ sudo tcpdump -V test.txt
```
Tất nhiên, mục đích của việc đọc nhiều tệp là để lọc nội dung để tìm kiếm một cái gì đó cụ thể. Chúng ta sẽ thấy các bộ lọc khác nhau bên dưới.

### Capture Packets from a specific source or destination IP (host address_or_fqdn)
```
$ sudo tcpdump host 192.168.1.1
$ sudo tcpdump host 2001:4860:4860::8888
```

### Capture Packets, filtered by source or destination IP (src address or dst address)
```
$ sudo tcpdump src 192.168.1.1
$ sudo tcpdump dst 2001:4860:4860::8888
```
### Capture Packets, filtered by network source or destination IP (net network)
```
$ sudo tcpdump net 192.168.0.0/24
$ sudo tcpdump net 2001:4860:4860::/64
```

### Capture Packets, without converting host addresses, port or protocols to names (-n)
```
$ sudo tcpdump dst port 80
14:17:37.124655 IP manjaro-xfce-20.local.32812 > zrh04s15-in-f4.1e100.net.http: Flags [S], seq 1529204080, win 64240, options [mss 1460,sackOK,TS val 766022782 ecr 0,nop,wscale 7], length 0
14:17:37.125833 IP manjaro-xfce-20.local.32812 > zrh04s15-in-f4.1e100.net.http: Flags [.], ack 64192002, win 64240, length 0
14:17:37.126166 IP manjaro-xfce-20.local.32812 > zrh04s15-in-f4.1e100.net.http: Flags [P.], seq 0:78, ack 1, win 64240, length 78: HTTP: GET / HTTP/1.1

$ sudo tcpdump -n dst port 80 
14:17:13.543893 IP 10.0.2.15.32808 > 172.217.168.68.80: Flags [S], seq 2815315033, win 64240, options [mss 1460,sackOK,TS val 765999201 ecr 0,nop,wscale 7], length 0
14:17:13.544509 IP 10.0.2.15.32808 > 172.217.168.68.80: Flags [.], ack 64064002, win 64240, length 0
14:17:13.544616 IP 10.0.2.15.32808 > 172.217.168.68.80: Flags [P.], seq 0:78, ack 1, win 64240, length 78: HTTP: GET / HTTP/1.1
```
### Capture Packets, filtered by port number or port range (port port_number | portrange port_number-port_number) – can be combined with dst or src
Nếu chúng ta không chỉ định cổng nguồn (src) hoặc cổng đích (dst), tcpdump sẽ nắm bắt cả hai hướng.

```
$ sudo tcpdump port 443
$ sudo tcpdump dst port 443
$ sudo tcpdump src portrange 1024-65535
```

### Capture Packets, filtered by protocol (icmp, tcp, udp, ip, ip6)
Chúng tôi có thể lọc các gói icmp, udp, tcp, nhưng cả các gói chỉ IPv4 (ip) hoặc IPv6 (ip6):

```
$ sudo tcpdump icmp
$ sudo tcpdump udp
$ sudo tcpdump tcp
$ sudo tcpdump ip
$ sudo tcpdump ip6
```
### Capture Packets, and exit after n packets (-c count)
Thoát sau khi nhận được số  gói tin.

```
$ sudo tcpdump -c 10
 (...)
 10 packets captured
 17 packets received by filter
 0 packets dropped by kernel
$
```

### Capture Packets, and print the data of each packet (-X)
Để in dữ liệu của từng gói (trừ tiêu đề mức liên kết của nó) dưới dạng hex và ASCII.

Dưới đây là một ví dụ, với ICMP ping tới 8.8.8.8, bao gồm một nội dung cụ thể trong mẫu dữ liệu ICMP:
```
$ ping -p "cafe" 8.8.8.8 
PATTERN: 0xcafe
PING 8.8.8.8 (8.8.8.8) 56(84) bytes of data.
64 octets de 8.8.8.8 : icmp_seq=1 ttl=63 temps=4.10 ms
64 octets de 8.8.8.8 : icmp_seq=2 ttl=63 temps=4.06 ms
(...)
```
Và kết quả của tcpdump cho ra rất nhiều cà phê (bằng tiếng Pháp):

```
$ sudo tcpdump -X icmp
(...)
11:00:06.783376 IP manjaro-xfce-20.local > dns.google: ICMP echo request, id 3, seq 1, length 64
0x0000: 4500 0054 8110 4000 4001 9d7a 0a00 020f E..T..@.@..z....
0x0010: 0808 0808 0800 b1ea 0003 0001 96d4 c160 ...............`
0x0020: 0000 0000 06f4 0b00 0000 0000 cafe cafe ................
0x0030: cafe cafe cafe cafe cafe cafe cafe cafe ................
0x0040: cafe cafe cafe cafe cafe cafe cafe cafe ................
0x0050: cafe cafe 
```
The option -x (lowercase) ho kết quả chỉ có phần hex:

```
$ sudo tcpdump -x icmp
(...)
11:08:54.070651 IP manjaro-xfce-20.local > dns.google: ICMP echo request, id 5, seq 1, length 64
0x0000: 4500 0054 d4c5 4000 4001 49c5 0a00 020f
0x0010: 0808 0808 0800 dbc6 0005 0001 a6d6 c160
0x0020: 0000 0000 d713 0100 0000 0000 cafe cafe
0x0030: cafe cafe cafe cafe cafe cafe cafe cafe
0x0040: cafe cafe cafe cafe cafe cafe cafe cafe
0x0050: cafe cafe
```
Và tùy chọn -A , cung cấp đầu ra chỉ với phần ASCII:
```
$ sudo tcpdump -A icmp
```

### Capture Packets, filtered by size (less | greater size)
Nếu bạn đang tìm kiếm các gói có kích thước cụ thể, bạn có thể sử dụng thuật ngữ “nhỏ hơn” hoặc “lớn hơn”. Đây là một ví dụ:

```
$ ping 8.8.8.8 -s 1
PING 8.8.8.8 (8.8.8.8) 1(29) bytes of data.
9 bytes from 8.8.8.8: icmp_seq=1 ttl=63
9 bytes from 8.8.8.8: icmp_seq=2 ttl=63
```
Ở đây, chúng ta phải xem xét kích thước của các tiêu đề: Ethernet không có CRC (14 byte) + IPv4 (20 byte) + ICMP (8 byte). Vì vậy, gói ping ICMP này, với 1 byte dữ liệu (-s 1), sẽ tạo ra tổng cộng 43 byte. Hãy thử xem:
```
$ sudo tcpdump -i 1 less 43
(...)
11:17:30.051339 IP manjaro-xfce-20.local > dns.google: ICMP echo request, id 10, seq 52, length 9
11:17:31.055479 IP manjaro-xfce-20.local > dns.google: ICMP echo request, id 10, seq 53, length 9
```

Tại thời điểm này, bạn nên nghĩ “ Nhưng nếu gói là 43 byte, tại sao lại ít hoạt động hơn?!? ”

Trên thực tế:

- chiều dài nhỏ hơn , tương đương với chiều dài "nhỏ hơn hoặc bằng" (<=)
- chiều dài lớn hơn , tương đương với chiều dài "lớn hơn hoặc bằng" (> =)
 

### Capture Packets, filtered by MAC-address (ether host mac) and display link-level header (-e)
Chúng ta có thể sử dụng từ khóa máy chủ ether để lọc lưu lượng truy cập đến một địa chỉ MAC hoặc các chương trình phát sóng, ví dụ:

```
$ sudo tcpdump ether host ff:ff:ff:ff:ff:ff
08:40:48.622995 ARP, Request who-has 10.0.2.20 tell manjaro-xfce-20.local, length 28
08:40:49.696943 ARP, Request who-has 10.0.2.20 tell manjaro-xfce-20.local, length 28
```
Here, I started the capture and tried to ping an IP on the same network, to catch the broadcast ARP packets.

But then we can use the -e option to print the link-level header on each dump line:

$ sudo tcpdump ether host ff:ff:ff:ff:ff:ff -e
08:46:06.625825 08:00:27:db:88:56 (oui Unknown) > Broadcast, ethertype ARP (0x0806), length 42: Request who-has 10.0.2.21 tell manjaro-xfce-20.local, length 28
With the -n option, it’s a bit easier to read:

$ sudo tcpdump ether host ff:ff:ff:ff:ff:ff -en
08:47:53.609426 08:00:27:db:88:56 > ff:ff:ff:ff:ff:ff, ethertype ARP (0x0806), length 42: Request who-has 10.0.2.21 tell 10.0.2.15, length 28
 

 

More advanced options and filters
Combine filters (and, or, not)
The ability to use the above filters is one thing, but the real power of tcpdump comes from the ability to combine these options to isolate what you are looking for. To do this, we can use the logical functions “and“, “or” and “not“. We can use parentheses (less recommended), quotes, or double quotes as separators.

$ sudo tcpdump ip6 and tcp
$ sudo tcpdump src portrange 1024-65535 and dst port 443
$ sudo tcpdump tcp and \( src portrange 1024-65535 and dst port 443 \)
$ sudo tcpdump tcp and 'src portrange 1024-65535 and dst port 443'
$ sudo tcpdump tcp and "src portrange 1024-65535 and dst port 443"
 

Adding verbosity to the output (-v, -vv, -vvv)
Tcpdump has three levels of verbosity. You can add more verbosity by adding additional “v” to the command-line options:

When parsing and printing, the -v option produces slightly more verbose output. For example, the time to live, identification, total length, and options in an IP packet are printed. Also enables additional packet integrity checks such as verifying the IP and ICMP header checksum. When writing to a file with the -w option and at the same time not reading from a file with the -r option, report to stderr, once per second, the number of packets captured. In Solaris, FreeBSD, and possibly other operating systems this periodic update currently can cause loss of captured packets on their way from the kernel to tcpdump.

The -vv option, even more verbose output. For example, additional fields are printed from NFS reply packets, and SMB packets are fully decoded.

The -vvv option, even more verbose output. For example, telnet SB … SE options are printed in full. With -X Telnet options are printed in hex as well.

 

Specify the capture size of each captured packets (-s snaplen)
By default, tcpdump will capture 262144 bytes. However, in some situations, you may not need to capture the default packet length. If you need to reduce the snapshot size below the default, you should limit snaplen to the smallest number that will capture the protocol information you’re interested in. Setting snaplen to 0 sets it to the default of 262144, for backward compatibility with recent older versions of tcpdump.

For example, if we want to capture only the first 14 bytes of the packets:

$ sudo tcpdump -s 14
 

Different timestamps options (-t, -tt, -ttt, -tttt, -ttttt)
By default, tcpdump will show as a timestamp for each packet, the local time of the system. But we can change this:

-t – Do NOT print a timestamp on each dump line.
-tt – Print the timestamp, as seconds since January 1, 1970, 00:00:00, UTC, and fractions of a second since that time, on each dump line.
-ttt – Print a delta (microsecond or nanosecond resolution depending on the –time-stamp-precision option) between the current and previous line on each dump line. The default is microsecond resolution.
-tttt – Print a timestamp, as hours, minutes, seconds, and fractions of a second since midnight, preceded by the date, on each dump line.
-ttttt – Print a delta (microsecond or nanosecond resolution depending on the –time-stamp-precision option) between current and first line on each dump line. The default is microsecond resolution.
In some situations, it’s useful to see the delta time between two packets, for example between a database request and the answer.

 

Identify the type of packets on the output (TCP Flag)
From this example below, we can say that the packet is a SYN-ACK packet. We can identify this by the Flags [S.] of the output, in red.

$ sudo tcpdump -tn src port 80
IP 172.217.168.68.80 > 10.0.2.15.32820: Flags [S.], seq 70400001, ack 171581542, win 65535, options [mss 1460], length 0
Different types of packets have different flags:

[S] – SYN
[S.] – SYN-ACK
[.] – No Flag Set
[P] – PSH (Push Data)
[F] – FIN (Finish)
[R] – RST (Reset)
You can find more on TCP flags here: https://www.howtouselinux.com/post/tcp-flags

 

Grep tcpdump output (-l)
The -l option means “line-readable output”, it lets you see the traffic as you capture it, and helps using commands like grep. For example:

$ sudo tcpdump -vvAls0 | grep 'GET'
As you can see, we usually combine this with -s0 to be sure to capture everything. See (-s snaplen) just above.

 

Even more complex filtering
TCP header search example
With tcpdump, we can search into the different fields of the TCP header for example. First, let’s take a look at the TCP header (source Wikipedia):

TCP header

Now, let’s say we want to filter all packets with the ACK flag set. So first, we specify the TCP byte, with TCP[byte_number], so TCP[13] in this case. See the byte number 13, for the flags, after the 4 bits of “data offset” and the 3 bits of “reserved”.

Then, we can specify the location within this byte. From right to left: FIN = 0, SYN = 2, RST = 4, PSH = 8, ACK = 16, etc… (yes, we specify this in decimal). So if we want to filter the ACK, we write it like this: TCP[13] & 16.

So, finally, if we want to see all packets with the ACK flag set (different to 0), we can do:

$ sudo tcpdump 'tcp[13] & 16 != 0'
IP header search example
We can do the same with the IP header, for example, to filter based on the ToS or DSCP value.

The ToS field is the second byte of the IP header, so byte number 1, because we start counting from 0. So we can search into IP[1] for ToS/DSCP values.

So, to find any packet with a non-zero ToS or DSCP value, we can do like this:

$ sudo tcpdump -v -n ip and ip[1]!=0
 

Then, a more complex use-case is to search for a specific DSCP value, let’s say we want to get all packets with expedite forwarding DSCP tag (DSCP EF), like voice packets in an enterprise network.

First, we have to remember some basic QoS rules: DSCP value of EF = 46 in decimal = 101110 in binary.

To this, we have to add the two first bits of ECN to build the entire ToS byte: = 10111000 = a decimal value of 184 = 0xB8 in hex.

Then, to filter this value, we could make:

$ sudo tcpdump -v -n 'ip and (ip[1] == 184)'
To make it easier, without having to convert DSCP 46 to ToS 184, let’s use a trick to ignore the first two bits and search the exact DSCP value:

$ sudo tcpdump -v -n 'ip and (ip[1] & 252) >> 2 == 46'
So, what happened there?

The 252 is the decimal value for 11111100, this is to ignore the value of the ECN bits, with the “bitwise AND”, written here with “&”. It also works without this, but with this, we are sure to take all the packets, whatever the value of the ECN bits.

Then, the “>>” is to eliminate the two first ECN bits from the value.  To “right-shift” them if you prefer. Like this, we can use the correct DSCP value, in decimal or hex:

$ sudo tcpdump -v -n 'ip and (ip[1] & 252) >> 2 == 0x2e'
We can verify with a ping to 8.8.8.8 with a DSCP value set to EF (DSCP 46 / 101110 == ToS 184 / 10111000):

$ ping 8.8.8.8 -Q 184
PING 8.8.8.8 (8.8.8.8) 56(84) octets de données.
64 octets de 8.8.8.8 : icmp_seq=1 ttl=118 temps=3.79 ms
64 octets de 8.8.8.8 : icmp_seq=2 ttl=118 temps=4.09 ms
64 octets de 8.8.8.8 : icmp_seq=3 ttl=118 temps=3.85 ms

$ sudo tcpdump -i 1 -t -v -n 'ip and (ip[1] & 252) >> 2 == 46'
IP (tos 0xb8, ttl 64, id 51956, offset 0, flags [DF], proto ICMP (1), length 84)
10.0.2.15 > 8.8.8.8: ICMP echo request, id 15, seq 54, length 64
IP (tos 0xb8, ttl 63, id 10245, offset 0, flags [DF], proto ICMP (1), length 84)
8.8.8.8 > 10.0.2.15: ICMP echo reply, id 15, seq 54, length 64
IP (tos 0xb8, ttl 64, id 52091, offset 0, flags [DF], proto ICMP (1), length 84)
10.0.2.15 > 8.8.8.8: ICMP echo request, id 15, seq 55, length 64

The same in hex:

$ sudo tcpdump -i 1 -t -v -n 'ip and (ip[1] & 0xfc) >> 2 == 0x2e'
IP (tos 0xb8, ttl 64, id 57009, offset 0, flags [DF], proto ICMP (1), length 84)
10.0.2.15 > 8.8.8.8: ICMP echo request, id 15, seq 86, length 64
IP (tos 0xb8, ttl 63, id 10277, offset 0, flags [DF], proto ICMP (1), length 84)
8.8.8.8 > 10.0.2.15: ICMP echo reply, id 15, seq 86, length 64
IP (tos 0xb8, ttl 64, id 57283, offset 0, flags [DF], proto ICMP (1), length 84)
10.0.2.15 > 8.8.8.8: ICMP echo request, id 15, seq 87, length 64
 

Everyday examples
 

Inspect HTTP traffic
Find HTTP User Agents
$ sudo tcpdump -vvAls0 | grep 'User-Agent:'
User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.101 Safari/537.36
Cleartext GET Requests
$ sudo tcpdump -vvAls0 | grep 'GET'
 GET /favicon.ico HTTP/1.1
Find HTTP Host Headers
$ sudo tcpdump -vvAls0 | grep 'Host:'
Host: www.google.com
Find HTTP Cookies
$ sudo tcpdump -vvAls0 | grep 'Set-Cookie|Host:|Cookie:'
Cookie: _ga=GA1.2.1819519503.1611300810; _fbp=fb.1.1611300810366.1600009966
Extract HTTP Request URL’s
$ sudo tcpdump -vnls0 | egrep -i "POST /|GET /|Host:"
 

 

Filter by traffic type
Find SSH Connections
$ sudo tcpdump 'tcp[(tcp[12]>>2):4] = 0x5353482D'
Note: This one works regardless of the port because it’s getting the banner response.

See the complex filtering part above for details.

Find DNS Traffic
$ sudo tcpdump -vvAs0 port 53
Find FTP Traffic
$ sudo tcpdump -vvAs0 port ftp or ftp-data
Find NTP Traffic
$ sudo tcpdump -vvAs0 port 123
 

Filter by TCP flag
See the complex filtering part above for details.

Show all ACK packets
$ sudo tcpdump 'tcp[13] & 16 != 0'
Show all PSH packets
$ sudo tcpdump 'tcp[13] & 8 != 0'
Show all RST packets
$ sudo tcpdump 'tcp[13] & 4 != 0'
Show all SYN packets
$ sudo tcpdump 'tcp[13] & 2 != 0'
Show all FIN packets
$ sudo tcpdump 'tcp[13] & 1 != 0'
Show all SYN-ACK packets
$ sudo tcpdump 'tcp[13] = 18'
 

QoS Filters
Show all IP packets with a non-zero TOS field (one byte TOS field is at offset 1 in IP header)
$ sudo tcpdump -v -n ip and ip[1]!=0
Show all IP packets with a DSCP value of EF (decimal 46)
$ sudo tcpdump -n -vvv 'ip and (ip[1] & 0xfc) >> 2 == 46'
 

Misc
Show icmp echo-request and echo-reply packets
$ sudo tcpdump -n icmp and 'icmp[0] = 8 or icmp[0] = 0'
The same, but to get any ICMP packets, except ping and ping-reply:
$ sudo tcpdump 'icmp[icmptype] != icmp-echo and icmp[icmptype] != icmp-echoreply'
Show ARP Packets, including the MAC address
$ sudo tcpdump -vv -e -nn ether proto 0x0806
Find Cleartext Passwords
$ sudo tcpdump port http or port ftp or port smtp or port imap or port pop3 or port telnet -lA | egrep -i -B5 'pass=|pwd=|log=|login=|user=|username=|pw=|passw=|passwd=|password=|pass:|user:|username:|password:|login:|pass |user '
Capture packets and write to multiple files, created every x time, with a timestamp into the filename
Here is an example to create a capture file every 10 seconds, so 6 capture files per minute, indefinitely, with the Month – Day – Hour – Minute – Seconds timestamp into the file name:

$ sudo tcpdump -G 10 -w test-%m-%d-%H-%M-%S.pcap
In this example, the -G option is equal to 10 seconds. So every 10 seconds we will have a new file. Please note that if we do not specify the Month and Day options, tcpdump will overwrite the files after 24 hours.