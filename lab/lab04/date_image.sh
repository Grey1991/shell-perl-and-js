#!/bin/sh
for file in "$@"
do
  ts=`ls -l "$file"|cut -d' ' -f6-8`
  nts=`stat "$file"|egrep "Modify"|cut -d' ' -f2-3|sed s/\.[0-9]*$//`
	convert -gravity south -pointsize 36 -draw "text 0,10 '$ts'" "$file" temporary_file.jpg
	mv temporary_file.jpg "$file"
	touch -d"$nts" "$file"
done
