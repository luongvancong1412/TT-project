# Chapter 41: Splitting Files - Tách tập tin

Đôi khi, rất hữu ích khi chia một tệp thành nhiều tệp riêng biệt. Nếu bạn có các tệp lớn, có thể là một ý kiến ​​haychia nó thành nhiều phần nhỏ hơn

## 41.1: Tách tệp - Split a file

Chạy lệnh tách mà không có bất kỳ tùy chọn nào sẽ chia tệp thành 1 hoặc nhiều tệp riêng biệt có chứa tối đa 1000mỗi dòng.

```
split file
```

Thao tác này sẽ tạo các tệp có tên xaa , xab , xac , v.v., mỗi tệp chứa tối đa 1000 dòng. Như bạn có thể thấy, tất cả chúng đềutiền tố là chữ x theo mặc định. Nếu tệp ban đầu ít hơn 1000 dòng, chỉ một tệp như vậy sẽ được tạo.

Để thay đổi tiền tố, hãy thêm tiền tố bạn muốn vào cuối dòng lệnh

```
split file customprefix
```

Bây giờ các tệp có tên là customprefixaa , customprefixab , customprefixac , v.v. sẽ được tạo

Để chỉ định số dòng cần xuất trên mỗi tệp, hãy sử dụng tùy chọn -l . Phần sau sẽ chia một tệp thành tối đa là5000 dòng

```
split -l5000 file
```

HOẶC LÀ

```
split --lines=5000 file
```

Ngoài ra, bạn có thể chỉ định số byte tối đa thay vì dòng. Điều này được thực hiện bằng cách sử dụng -b hoặc --bytetùy chọn. Ví dụ: để cho phép tối đa 1MB

```
split --bytes=1MB file
```