#!/bin/bash

clear
echo "Nhap noi dung:"
read noidung

token=5074962515:AAFkjHSKmX2nfQ6_Ge2y2c8Zvv-3LUfU5Og
ID=-604968007
url=https://api.telegram.org/bot${token}/sendMessage

curl -d chat_id=$ID -d text="$noidung" $url

printf "=================================================\n"
printf "Gui:$noidung toi group Telegram thanh cong \n"
printf "=================================================\n"