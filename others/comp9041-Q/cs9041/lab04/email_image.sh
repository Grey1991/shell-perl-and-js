#!/bin/sh

for file in "$@"
do 
	display "$file"
	echo -n "Address to e-mail this image to?"
	read address
	echo -n "Message to accompany image?"
	read message
	subtitle=`echo "$file"|sed s/"\.jpg"/\!/|sed s/"\.png"/\!/`
	echo "$message"|mutt -s "$subtitle" -e 'set copy=no' -a "$file" -- "$address"
done
