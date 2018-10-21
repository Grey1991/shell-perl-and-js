#!/bin/sh
for file in *
do
	if [[ $file =~ \.jpg$ ]]
	then
		newfile=`echo $file |sed s/"\.jpg"/".png"/g`
		if test -e "$newfile"
		then 
			echo "$newfile already exists"
		else
			#echo $file $newfile			
			convert "$file" "$newfile"
			rm "$file"
		fi
	fi
done
