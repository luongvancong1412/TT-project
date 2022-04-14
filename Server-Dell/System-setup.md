<h1> System setup </h1>

<h2> Mục lục </h2>

- [1. Các bước vào system setup](#1-các-bước-vào-system-setup)
- [2. System BIOS](#2-system-bios)

# I. System Setup

Mở System Setup để cấu hình:
- System BIOS
- iDRAC Settings
- Device Settings

Các bước mở System Setup:
1. Khởi động server
2. Nhấn phím `<F2>`


![Imgur](https://i.imgur.com/3BhygG0.png)

1. Chọn 1 trong 3 option của system setup

![Imgur](https://i.imgur.com/0wBSOnN.png)

# II. System BIOS

- Click `System BIOS` để vào BIOS

![Imgur](https://i.imgur.com/0wBSOnN.png)

## 1. Chi tiết System BIOS

![Imgur](https://i.imgur.com/FmQ7Yz1.jpg)

![Imgur](https://i.imgur.com/LlM54gD.jpg)

|Option|Description|
|---|---|
System Information|Cung cấp thông tin về hệ thống như: the system model name (tên kiểu hệ thống), BIOS version và Service Tag.
Memory Settings|Cung cấp thông tin và các tùy chọn liên quan đến bộ nhớ (Memory) đã cài đặt.
Processor Settings|Cung cấp thông tin và các tùy chọn liên quan đến bộ xử lý (processor) như speed (tốc độ) và cache size (kích thước bộ nhớ đệm).
SATA Settings|Cung cấp các tùy chọn để enable or disable SATA controller và ports.
NVMe Settings|Cung cấp các option để thay đổi NVMe settings. If the system contains the NVMe drives that you want to configure in a RAID array, you must set both this field and the Embedded SATA field on the SATA Settings menu to RAID mode. You might also need to change the Boot Mode setting to UEFI. Otherwise, you should set this field to Non-RAID mode.
Boot Settings|Cung cấp các option để chọn chế độ khởi động - Boot mode (là BIOS hoặc UEFI). Cho phép sửa đổi cài đặt boot UEFI and BIOS.
Network Settings|Cung cấp các option để quản lý UEFI network settings and boot protocols. Legacy network settings được quản lý từ menu Device Settings.
Integrated Devices|Cung cấp các option để quản lý integrated device controllers and ports, các tính năng và option liên quan.
Serial Communication|Cung cấp các option để quản lý serial ports, các tính năng và option liên quan.
System Profile Settings|Cung cấp các tùy chọn để thay đổi processor power management settings (các cài đặt quản lý bộ sử lý nguồn), and memory frequency (tần số bộ nhớ).
System Security|Cung cấp các tùy chọn để cấu hình system security settings như system password, setup password, Trusted Platform Module (TPM) security, and UEFI secure boot. Nó cũng quản lý nút nguồn trên hệ thống.
Redundant OS Control|Đặt thông tin redundant OS (OS dự phòng) để kiểm soát redundant OS
Miscellaneous Settings|Cung cấp các tùy chọn để thay đổi system date and time.|

### 1.1 System Information

![Imgur](https://i.imgur.com/fiZ6Rrf.jpg)

Option|Description|
|---|---|
System Model Name|Hiển thị tên server.
System BIOS Version|Hiển thị phiên bản BIOS được cài đặt trên hệ thống.
System Management Engine Version|Hiển thị phiên bản hiện tại của Công cụ quản lý hệ thống.
System Service Tag|Hiển thị số Service Tag.
System Manufacturer|Hiển thị tên nhà sản xuất hệ thống.
System Manufacturer Contact Information|Hiển thị thông tin liên hệ nhà sản xuất hệ thống.
System CPLD Version|Hiển thị thông tin phiên bản complex programmable logic device (CPLD) hiện tại của hệ thống.
UEFI Compliance Version|Hiển thị phiên bản của UEFI compliance.

### 1.2 Memory Settings

![Imgur](https://i.imgur.com/mzZcAA9.jpg)


Option|Description|
|---|---|
System Memory Size|Hiển thị kích thước bộ nhớ trong hệ thống.
System Memory Type|Hiển thị loại bộ nhớ được cài đặt trong hệ thống.
System Memory Speed|Hiển thị tốc độ bộ nhớ hệ thống.
System Memory Voltage|Hiển thị điện áp (voltage) của bộ nhớ hệ thống.
Video Memory|Hiện thị dung lượng bộ nhớ video.
System Memory Testing| Hiển thị xem kiểm tra bộ nhớ hệ thống có được chạy trong quá trình khởi động hệ thống không. Có 2 Option là Enabled và Disabled. Mặc định là Disabled.
Dram Refresh Delay|**Performance** - Cho phép `CPU memory controller` delay việc chạy các lệnh **REFRESH** , ta có thể cải thiện hiệu suất cho một số khối lượng công việc (you can improve the performance for some workloads). **Minimum** - Giảm thiểu thời gian delay, nó đảm bảo `memory controller` chạy lệnh REFRESH trong khoảng thời gian cố định (at regular intervals). Đối với servers dựa trên intel-based, cài đặt này chỉ ảnh hưởng đến các hệ thống được cấu hình với DIMMs sử dụng DRAMS 8 Gb (use 8 Gb density DRAMS).

Memory Operating Mode| Chọn các mode memory operating (chế độ vận hành bộ nhớ). Các option có sẵn là **Optimizer Mode** (chế độ tối ưu hoá), **Single Rank Spare Mode** (Chế độ dự phòng xếp hạng đơn), **Multi Rank Spare Mode** (Chế độ dự phòng nhiều hạng) và Mirror Mode (Chế độ phản chiếu - bản sao). **Cấu hình mặc định** là **Optimizer Mode**.|
Current State of Memory Operating Mode|Hiển thị trạng thái hiện tại của **memory operating mode**.
Node Interleaving|Hiển thị  **Non-Uniform Memory Architecture (NUMA)** có hỗ trợ không. Nếu trường này là **Enabled**, **memory interleaving** (tính năng xen kẽ bộ nhớ) được hỗ trợ nếu **symmetric memory configuration** (cấu hình bộ nhớ đối xứng) được cài đặt. Nếu trường này là **Disabled**, Hệ thống hỗ trợ cấu hình bộ nhớ NUMA (asymmetric - không đối xứng). Option này mặc định là **Disable**
ADDDC Setting|Enables hoặc disables tính năng **ADDDC Setting**. Khi enabled  tính năng Adaptive Double DRAM Device Correction (ADDDC), failing DRAMs are dynamically mapped out (các DRAM lỗi sẽ được ánh xạ động). Khi được đặt thành Enabled nó có thể có một số tác động đến hiệu suất hệ thống (system performance) trong một số khối lượng công việc nhất định (certain workloads). Tính năng chỉ áp dụng cho các DIMM x4. Option này mặc định là **Enabled**.
Native tRFC Timing for 16Gb DIMMs|Enables 16 Gb density DIMMs hoạt động ở Row Refresh Cycle Time (tRFC) được lập trình. Bật tính năng này có thể cải thiện hiệu suất hệ thống đối với 1 số cấu hình. Tuy nhiên, việc bật tính năng này không ảnh hưởng đến cấu hình với 16 Gb 3DS/TSV DIMMs. Option mặc định là **Enabled**.
Opportunistic Self-Refresh|Option mặc định là Disable và không được hỗ trợ khi DCPMM có trong hệ thống.
Correctable Error logging|Ghi nhật ký lỗi có thể sửa chữa. Option này mặc định là disable.
DIMM Self Healing (Post Package Repair) on Uncorrectable Memory Error|Enable/Disable Post Package Repair (PPR) on Uncorrectable Memory Error. Option này mặc định là Enabled.|

### 1.3 Processor Settings

![Imgur](https://imgur.com/5lk6ia3)

![Imgur](https://imgur.com/CgoJ7hM)

![Imgur](https://imgur.com/bWegmTV)




# Tài liệu tham khảo
1. https://www.dell.com/support/manuals/en-vn/poweredge-r440/per440_bios_pub/system-setup?guid=guid-d926fd8d-a977-4289-b1e7-45d0fe546139&lang=en-us