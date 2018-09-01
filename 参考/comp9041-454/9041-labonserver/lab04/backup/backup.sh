#!/bin/sh
i=$(sed 's/\.[^\ ]*\ /\n/g' <<< "$*" |sed 's/\..*//'|wc -l)
for((na=1;na<=$i;na++))
do
  j=$(sed 's/\.[^\ ]*\ /\n/g' <<< "$*" |sed 's/\..*//'|sed -n "$na"p)
  name=$(ls -l|egrep -o "$j\.[^ ]+")
  display "$name"
  echo -n "Address to e-mail this image to? "
  read addr
  echo -n "Message to accompany image? "
  read message
  file_name=$(echo "$name"|sed 's/\..*//')
  echo "$message"|mutt -s "$file_name!" -a "$name" -e "set copy=no" -- "$addr"
  echo "$name sent to $addr"
done
