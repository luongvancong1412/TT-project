# Chapter 50: Color script output (crossplatform) - Đầu ra tập lệnh màu (chéo-nền tảng)

## 50.1: color-output.sh

Trong phần mở đầu của tập lệnh bash, có thể xác định một số biến có chức năng như trình trợ giúp tô màu hoặc nếu không thì định dạng đầu ra đầu cuối trong quá trình chạy tập lệnh.

Các nền tảng khác nhau sử dụng các chuỗi ký tự khác nhau để thể hiện màu sắc. Tuy nhiên, có một tiện ích gọi là tput màhoạt động trên tất cả các hệ thống * nix và trả về các chuỗi màu thiết bị đầu cuối dành riêng cho nền tảng thông qua một API đa nền tảng nhất quán.

Ví dụ: để lưu trữ chuỗi ký tự biến văn bản đầu cuối thành màu đỏ hoặc xanh lục:

```
red=$(tput setaf 1)
green=$(tput setaf 2)
```

Hoặc, để lưu trữ chuỗi ký tự đặt lại văn bản về giao diện mặc định:

```
reset=$(tput sgr0)
```

Sau đó, nếu tập lệnh BASH cần thiết để hiển thị các đầu ra có màu khác nhau, điều này có thể đạt được với:
cho `"${green}Success!${reset}" echo "${red}Failure.${reset}"`