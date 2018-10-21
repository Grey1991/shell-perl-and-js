#!/bin/sh
if test $# = 2
then
	start=1	
	max=$1
	string=$2
else
	echo "Usage: $0 <number of lines> <string>"
	exit 1
fi 

if test $max -ge 0 2>/dev/null
then 
	while test $start -le $max
	do
	echo $string	
	start=$(($start + 1))
	done
else
	echo "$0: argument 1 must be a non-negative integer"
	exit 1
fi 




