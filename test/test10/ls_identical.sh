#!/bin/sh 
result=()
for file in "$1"/*
do
    filename=`basename "$file"`
    if test -f "$2/$filename"
    # echo $filename
    then
        if diff "$file" "$2/$filename" >/dev/null
        then
            result+=("$filename")
            # echo yes
        fi
    fi
done

# sorted=`echo "${result[@]}" | sort`
# for e in $sorted; do
#     echo "$e"
# done
if test ${#result[@]} -gt 0;then
    printf '%s\n' "${result[@]}" | sort
fi