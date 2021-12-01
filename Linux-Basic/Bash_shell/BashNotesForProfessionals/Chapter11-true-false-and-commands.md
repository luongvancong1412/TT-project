# Chapter 11: true, false and : commands - Lệnh true, false và ":"

- [Chapter 11: true, false and : commands - Lệnh true, false và ":"](#chapter-11-true-false-and--commands---lệnh-true-false-và-)
  - [11.1: Infinite Loop - Vòng lặp vô hạn](#111-infinite-loop---vòng-lặp-vô-hạn)
  - [11.2: Function Return - Hàm trả về](#112-function-return---hàm-trả-về)
  - [11.3: Code that will always/never be executed - Code "sẽ luôn/không bao giờ" được thực thi](#113-code-that-will-alwaysnever-be-executed---code-sẽ-luônkhông-bao-giờ-được-thực-thi)


## 11.1: Infinite Loop - Vòng lặp vô hạn
```
while true; do
    echo ok
done
```
or
```
while :; do
    echo ok
done
```
or
```
until false; do
    echo ok
done
```
## 11.2: Function Return - Hàm trả về
```
function positive() {
    return 0
}
function negative() {
    return 1
}
```
## 11.3: Code that will always/never be executed - Code "sẽ luôn/không bao giờ" được thực thi
```
if true; then
    echo Always executed
fi
if false; then
    echo Never executed
fi
```