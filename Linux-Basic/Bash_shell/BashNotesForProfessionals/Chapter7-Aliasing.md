# Chapter 7: Aliasing

- [Chapter 7: Aliasing](#chapter-7-aliasing)
  - [Section 7.1: Bypass an alias (Tắt bí danh tạm thời)](#section-71-bypass-an-alias-tắt-bí-danh-tạm-thời)
  - [Section 7.2: Create an Alias (Tạo bí danh)](#section-72-create-an-alias-tạo-bí-danh)
  - [Section 7.3: Remove an alias (Xoá bí danh)](#section-73-remove-an-alias-xoá-bí-danh)
  - [Section 7.4: BASH_ALIASES is an internal bash assoc array](#section-74-bash_aliases-is-an-internal-bash-assoc-array)
  - [Section 7.5: Expand alias (Mở rộng bí danh)](#section-75-expand-alias-mở-rộng-bí-danh)
  - [Section 7.6: List all Aliases (Liệt kê tất cả các bí danh)](#section-76-list-all-aliases-liệt-kê-tất-cả-các-bí-danh)

Bí danh Shell là một cách đơn giản để tạo các lệnh mới hoặc bọc các lệnh hiện có bằng mã của riêng bạn. Họhơi trùng lặp với các hàm shell, tuy nhiên nó linh hoạt hơn và do đó thường được ưu tiên hơn.
## Section 7.1: Bypass an alias (Tắt bí danh tạm thời)
Đôi khi bạn có thể muốn bỏ qua bí danh tạm thời mà không cần tắt nó. Để làm việc với một ví dụ cụ thể,hãy xem xét bí danh này:

```alias ls='ls --color=auto'```


Và giả sử bạn muốn sử dụng lệnh ls mà không cần tắt bí danh. Bạn có một số tùy chọn:

- Sử dụng các lệnh dựng sẵn: lệnh `ls`
- Sử dụng đường dẫn đầy đủ của lệnh: `/bin/ls`
- Thêm \ vào bất kỳ đâu trong tên lệnh, ví dụ: `\ls`, or `l\s`
- Trích dẫn lệnh: "ls" or 'ls'

## Section 7.2: Create an Alias (Tạo bí danh)

```alias word='command'```

Gọi chữ sẽ chạy `command` . Bất kỳ đối số nào được cung cấp cho bí danh chỉ được thêm vào đích của bí danh:
```
alias myAlias='some command --with --options'
myAlias foo bar baz
```

Sau đó, shell sẽ thực thi:

```some command --with --options foo bar baz```

Để bao gồm nhiều lệnh trong cùng một bí danh, bạn có thể xâu chuỗi chúng lại với nhau bằng && . Ví dụ:

```alias print_things='echo "foo" && echo "bar" && echo "baz"'```

## Section 7.3: Remove an alias (Xoá bí danh)

Để xoá bí danh hiện có, use:

```unalias {alias_name}```

Example:

```
# create an alias
$ alias now='date'
# preview the alias
$ now
Thu Jul 21 17:11:25 CEST 2016
# remove the alias
$ unalias now
# test if removed
$ now
-bash: now: command not found
```

## Section 7.4: BASH_ALIASES is an internal bash assoc array

Bí danh được đặt tên là các phím tắt của lệnh, người ta có thể xác định và sử dụng trong các phiên bản bash tương tác. Họ được tổ chức trongmột mảng kết hợp có tên BASH_ALIASES. Để sử dụng var này trong một tập lệnh, nó phải được chạy trong một trình bao tương tác

```
#!/bin/bash -li
# note the -li above! -l makes this behave like a login shell
# -i makes it behave like an interactive shell
#
# shopt -s expand_aliases will not work in most cases
echo There are ${#BASH_ALIASES[*]} aliases defined.
for ali in "${!BASH_ALIASES[@]}"; do
printf "alias: %-10s triggers: %s\n" "$ali" "${BASH_ALIASES[$ali]}"
done
```

## Section 7.5: Expand alias (Mở rộng bí danh)

Giả sử bar là bí danh cho `Command -flag1`.
Gõ bar trên dòng lệnh rồi nhấn `Ctrl + alt + e`
Bạn sẽ nhận được `someCommand -flag1` nơi bar đang đứng.

## Section 7.6: List all Aliases (Liệt kê tất cả các bí danh)

```alias -p```

sẽ liệt kê tất cả các bí danh hiện tại.