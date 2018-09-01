#!/bin/sh
for f in "$@"
do
	files=`cat "$f"|egrep "^#include \""|cut -d\" -f2`
	for file in $files
	do
		if [ ! -e $file ]
		then
			echo "$file" included into "$f" does not exist
		fi
	done
done
