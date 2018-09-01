#!/bin/sh
if test $# -ne 2
then
echo 'Usage: ./echon.sh <number of lines> <string>'
exit
fi
if egrep -v "^[^-0][0-9]*$|^0$">/dev/null <<< "$1"
then
echo './echon.sh: argument 1 must be a non-negative integer'
exit
fi
for((i=1;i<=$1;i++))
do
echo "$2"
done
