#!/bin/sh
for name in *
do
  if egrep -o "$name" <<< "$*" >/dev/null
  then
  display "$name"
  echo -n "Address to e-mail this image to? "
  read addr
  echo -n "Message to accompany image? "
  read message
  file_name=$(echo $name|sed 's/\..*//')
  echo "$message"|mutt -s "$file_name!" -a "$name" -e "set copy=no" -- "$addr"
  echo "$name sent to $addr"
  fi
done
