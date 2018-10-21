#!/bin/sh
for name in *
do
  if egrep -o "$name" <<< "$*" >/dev/null
  then
  message=$(ls -l "$name"|egrep -o "[A-Z][a-z][a-z].*"|cut -c1-12)
  mtime=$(ls --full-time "$name"|egrep -o [0-9]{2}:[0-9]{2}:[0-9]{2}.[0-9]*)
  convert -gravity south -pointsize 36 -draw "text 0,10 '$message'" "$name" temporary_file.jpg
  mv temporary_file.jpg "$name"
  touch -d "$message $mtime" "$name"
  fi
done
