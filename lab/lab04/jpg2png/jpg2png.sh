#!/bin/sh
for file in *.jpg
do
  file_name=$(echo $file |sed 's/.jpg//')
  if test -f "$file_name.png"
  then
    echo $file_name.png already exists
    exit
  fi
  convert "$file" "$file_name.png"
  rm "$file"
done
