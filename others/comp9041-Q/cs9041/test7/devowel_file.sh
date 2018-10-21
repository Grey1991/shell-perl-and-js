#!/bin/sh
file="$1"
sed 's/[aeiou]//gi' $file > tmp
mv tmp $file




















# file=$1
# sed s/[aeiou]//ig $file > tmp
# cat tmp > $file
