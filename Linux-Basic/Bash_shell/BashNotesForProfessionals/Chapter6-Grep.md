# Chapter 6: Grep
## Section 6.1: How to search a file for a pattern (Cách tìm kiếm một tệp cho một mẫu)

Để tìm từ `foo` trong file bar:

```grep foo ~/Desktop/bar```

Để tìm tất cả các dòng `không` chứa `foo` trong file bar:

```grep –v foo ~/Desktop/bar```

Để sử dụng, tìm tất cả các từ có chứa `foo` cuối cùng (Mở rộng thẻ WIldcard):

```grep "*foo" ~/Desktop/bar```