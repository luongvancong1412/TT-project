# Chapter 13: Associative arrays - Mảng liên kết

## 13.1:Examining assoc arrays - Kiểm tra mảng giả định

Tất cả mức sử dụng cần thiết được hiển thị với đoạn mã này:
```
#!/usr/bin/env bash
declare -A assoc_array=([key_string]=value                                  \
                        [one]="something"                                   \
                        [two]="another thing"                               \
                        [ three ]='mind the blanks!'                        \
                        [ " four" ]='count the blanks of this key later!'   \
                                            [IMPORTANT]='SPACES DO ADD UP!!!'
\
                        [1]='there are no integers!'                        \
                        [info]="to avoid history expansion "                \
                        [info2]="quote exclamation mark with single quotes" \
                        )
echo # chỉ là một dòng trống
echo bây giờ đây là các giá trị của assoc_array:
echo ${assoc_array[@]}
echo không hữu ích,
echo # chỉ là một dòng trống
echo this is better:

declare -p assoc_array # -p == print

echo Hãy xem kỹ các khoảng trống ở trên\!\!\!
echo # chỉ là một dòng trống

echo truy cập các phím
echo các khoá trong assoc_array là ${!assoc_array[*]}
echo nhớ lại việc sử dụng toán tử chuyển hướng\!
echo # chỉ là một dòng trống


echo now we loop over the assoc_array line by line
echo note the \! indirection operator which works differently,
echo if used with assoc_array.
echo # chỉ là một dòng trống

for key in "${!assoc_array[@]}"; do # truy cập các khoá bằng cách sử dụng! chuyển hướng!!!!
    printf "key: \"%s\"\nvalue: \"%s\"\n\n" "$key" "${assoc_array[$key]}"
done


echo have a close look at the spaces in entries with keys two, three and four above\!\!\!
echo # chỉ là một dòng trống
echo # chỉ là một dòng trống khác

echo there is a difference using integers as keys\!\!\!
i=1
echo khai báo một số nguyên var i=1
echo # chỉ là một dòng trống
echo Within an integer_array bash recognizes artithmetic context.
echo Within an assoc_array bash DOES NOT recognize artithmetic context.
echo # chỉ là một dòng trống
echo this works: \${assoc_array[\$i]}: ${assoc_array[$i]}
echo this NOT!!: \${assoc_array[i]}: ${assoc_array[i]}
echo # chỉ là một dòng trống
echo # chỉ là một dòng trống
echo an \${assoc_array[i]} has a string context within braces in contrast to an integer_array
declare -i integer_array=( one two three )
echo "doing a: declare -i integer_array=( one two three )"
echo # chỉ là một dòng trống

echo both forms do work: \${integer_array[i]} : ${integer_array[i]}
echo and this too: \${integer_array[\$i]} : ${integer_array[$i]}
```