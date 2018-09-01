#!/bin/sh
start=$1
end=$2
file_name=$3
if test -f $file_name
then
  rm $file_name
fi
for((i=$start;i<=$end;i++))
do
  echo $i>>$file_name
done
