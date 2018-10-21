#!/bin/sh
small="Small files:"
medium="Medium-sized files:"
large="Large files:"
for file in *
do
	line=`wc -l $file |cut -d' ' -f1`
	if test $line -lt 10
	then
		small="$small $file"
	elif test $line -ge 100
	then
		large="$large $file"
	else 
		medium="$medium $file"
	fi
done

echo $small
echo $medium
echo $large
