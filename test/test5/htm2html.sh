#!/bin/sh
for file in *.htm
do
  new="$file"l
  if test -e "$new"
  then
    echo "$new exists"
    exit 1
  else
    mv "$file" "$new"
  fi
done
