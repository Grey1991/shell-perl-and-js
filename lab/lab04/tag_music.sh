#!/bin/sh
for path in "$@"
do
	for file in "$path"/*
	do
    title=`echo "$file"|tr -s '/'|sed 's/ - /\t/g'|cut -f2|egrep -v '/'`
		artist=`echo "$file"|tr -s '/'|sed 's/ - /\t/g'|cut -f3|sed 's/\.mp3//'|egrep -v '/'`
		album=`echo "$file"|tr -s '/'|cut -d'/' -f2`
		year=`echo "$album"|tr -s '/'|cut -d',' -f2|cut -c 2-`
		track=`echo "$file"|tr -s '/'|cut -d'/' -f3|cut -d' ' -f1`
		id3 -t"$title" -a"$artist" -T"$track" -A"$album" -y"$year" "$file">/dev/null
	done
done
