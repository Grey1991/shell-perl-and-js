#!/bin/sh
if test $# -ne 2
then
	echo 'Usage: ./echon.sh <number of lines> <string>'
	exit 1
fi
if test $1 -ge 0 2>/dev/null
then
	for ((i=0;i<$1;i++)) do
		echo $2
	done
else
	echo "$0: argument 1 must be a non-negative integer"
	exit 1
fi
