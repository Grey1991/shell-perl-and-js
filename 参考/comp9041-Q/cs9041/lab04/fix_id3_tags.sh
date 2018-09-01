#!/bin/sh
for path in "$@"
do
	#cd "$path"
	#for file in *	
	for file in "$path"/*
	do
		title=`echo "$file"|tr -s '/'|cut -d'-' -f2-|cut -c 2-|egrep -o "^.* - "|sed s/' - '//`		
		artist=`echo "$file"|tr -s '/'|cut -d'-' -f2-|cut -c 2-|egrep -o " - .*$"|cut -c4-|sed s/"\.mp3$"//`
		album=`echo "$file"|tr -s '/'|cut -d'/' -f2`		
		year=`echo "$album"|tr -s '/'|cut -d',' -f2|cut -c 2-`		
		track=`echo "$file"|tr -s '/'|cut -d'/' -f3|cut -d' ' -f1`
		id3 -t"$title" -a"$artist" -T"$track" -A"$album" -y"$year" "$file">/dev/null

		#echo $artist
	done
done
