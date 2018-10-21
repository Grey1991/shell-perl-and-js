#!/bin/sh
for file in "$@"
do
    hfiles=`cat "$file"|egrep "^#include \""|egrep -o "[^\"]*\.h"`
    for line in $hfiles
    do        
        if test ! -e "$line"
        then
            echo "$line included into $file does not exist"
        fi
    done
done
