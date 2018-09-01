#!/bin/sh
for file in "$@"
do
  display "$file"
  echo -n "Address to e-mail this image to? "
  read address
  echo -n "Message to accompany image? "
  read message
  file_name=`echo $file|sed s/"\..*"/\!/`
  echo "$message"|mutt -s "$file_name!" -a "$file" -e "set copy=no" -- "$address"
  echo "$file sent to $address"
done
