#!/bin/sh
for file in *.htm
do
  file_name=$(echo "$file"|sed 's/.htm//')
  if test -f "$file_name.html"
  then
    echo "$file_name.html exists"
    exit 1
  fi
  mv "$file" "$file_name.html" 
done
