#!/bin/sh
for file in *.htm
do
	new="$file"l
	if [ -e "$new" ]
	then
		echo "$file" exists
		exit 1
	else
		cp "$file" "$new"
		rm "$file"
	fi
done
