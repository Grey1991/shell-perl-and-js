#!/bin/sh
for file in "$@"
do
  hn=$(egrep "#include \".*\"" "$file"|egrep -o "\".*\""|sed 's/\"//g')
  line=$(echo "$hn"|wc -l)
  for((i=1;i<=$line;i++))
  do
    fn=$(echo "$hn"|sed -n "$i p")
    if !(test -f "$fn")
     then
      echo "$fn included into $file does not exist"
    fi
  done
done
