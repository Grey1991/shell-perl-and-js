#!/bin/sh
min="$1"
max="$2"
file="$3"
if test ! -e $file
then
  while test $min -le $max
  do
    echo $min
    min=`expr $min + 1`
  done >> $file
fi






















# min=$1
# max=$2
# name=$3
# while test $min -le $max
# do
#     echo $min >> $3
#     min=`expr $min + 1`
# done
