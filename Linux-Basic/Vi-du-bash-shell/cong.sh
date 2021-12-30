#! /bin/bash
for name in {1..100}; do
	touch "cong_$name.txt"
	echo $name > "cong_$name.txt"
	date +"%H:%M:%S.%3N" >> "cong_$name.txt"
done