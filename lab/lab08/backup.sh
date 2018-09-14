#!/bin/sh
file=$1;
i=0;
backup=".$file.$i"
while test -e "$backup"; do
  ((i++));
  backup=".$file.$i";
done
cp $file $backup;
echo "Backup of '$file' saved as '$backup'"
