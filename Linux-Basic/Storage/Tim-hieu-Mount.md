# Tìm hiểu Mount

# I. Tổng quan
## 1. Khái niệm
Mount là một quá trình mà trong đó hệ điều hành làm cho các tập tin và thư mục trên một thiết bị lưu trữ (như ổ cứng, CD-ROM hoặc tài nguyên chia sẻ) có thể truy cập được bởi người dùng thông qua hệ thống tệp của máy tính.[1]

Nói chung, quá trình mount bao gồm việc hệ điều hành được truy cập vào phương tiện lưu trữ, công nhận, đọc và xử lý cấu trúc hệ thống tệp cùng với siêu dữ liệu trên nó, sau đó, đăng ký chúng vào thành phần hệ thống tệp ảo (VFS).

Vị trí đăng ký trong VFS của phương tiện mới được mount gọi là điểm mount. Đây là điểm mà người dùng có thể truy cập tập tin, thư mục của phương tiện sau khi quá trình mount hoàn thành.

Ngược với mount là unmount, trong đó, hệ điều hành huỷ tất cả quyền truy cập tập tin, thư mục của người dùng tại điểm mount, ghi tiếp những dữ liệu người dùng đang trong hàng đợi vào thiết bị, làm mới siêu dữ liệu hệ thống tệp, sau đó, tự huỷ quyền truy cập thiết bị và làm cho thiết bị có thể tháo ra an toàn.

Bình thường, khi tắt máy tính, mỗi thiết bị lưu trữ sẽ trải qua quá trình unmount để đảm bảo rằng tất cả các dữ liệu trong hàng đợi được ghi và để duy trì tính toàn vẹn của cấu trúc hệ thống tệp trên các phương tiện.
mount được sử dụng để gắn kết hệ thống tệp được tìm thấy trên thiết bị với cấu trúc cây lớn ( hệ thống tệp Linux ) có gốc tại ' / '.
Ngược lại, một lệnh umount có thể được sử dụng để tách các thiết bị từ Tree.

Một điểm mount là một vị trí vật lý trong phân vùng được sử dụng như hệ thống tệp gốc (root filesystem). Có nhiều loại thiết bị lưu trữ, chẳng hạn đĩa từ, từ – quang, quang, và bán dẫn. Tính đến năm 2013, đĩa từ vẫn phổ biến nhất, thông dụng như đĩa cứng hoặc ít thông dụng hơn như đĩa mềm. Trước khi chúng có thể được sử dụng để lưu trữ, tức là có thể đọc ghi thông tin, chúng phải được tổ chức và hệ điều hành phải biết về điều này. Sự tổ chức ấy gọi là hệ thống tệp. Mỗi hệ điều hành có một hệ thống tệp khác nhau cung cấp cho nó siêu dữ liệu để nó biết cách đọc ghi ra sao. Hệ điều hành sẽ đọc những siêu dữ liệu ấy khi phương tiện được mount.[2][3]

Các hệ điều hành Unix-like thường bao gồm phần mềm và công cụ hỗ trợ quá trình mount cũng như cung cấp chức năng mới cho nó. Một số trong những chiến lược này đã được đặt ra là "auto-mounting" (mount tự động) để phản ánh mục đích của chúng.

Trong nhiều trường hợp, những hệ thống tệp không phải gốc vẫn cần sẵn sàng ngay khi hệ điều hành khởi động. Tất cả các hệ thống Unix-like đều cung cấp tiện ích để làm điều này. Quản trị viên hệ thống xác định những hệ thống tệp đó trong tập tin cấu hình fstab (vfstab trong Solaris), tập tin này cũng kèm theo các tuỳ chọn và điểm mount. Trong một số trường hợp khác, có những hệ thống tệp nhất định không cần mount khi khởi động dù có cần sử dụng sau đó hay không. Vài tiện ích của các hệ thống Unix-like cho phép mount những hệ thống tệp đã định trước chỉ khi nào cần tới.

## 2.Cú pháp

```mount [OPTION...] DEVICE_NAME DIRECTORY```

## 3.Tuỳ chọn
|Tuỳ chọn|Mô tả|
|---|---|
-V| Phiên bản đầu ra
-h|--help, In thông báo trợ giúp
-v, --verbose| Chế độ chi tiết
-a, --all| Gắn kết tất cả các hệ thống tệp được đề cập trong fstab(file cấu hình)
-F, --fork|
-f, --fake|
-i, --internal-only|
-l, --show-labels|
-n, --no-mtab|
-c, --no-canonicalize|
-r, --read-only|
-w, 

## 
# Tài liệu tham khảo

1. https://vi.wikipedia.org/wiki/Mount_(m%C3%A1y_t%C3%ADnh)
2. https://man7.org/linux/man-pages/man8/mount.8.html