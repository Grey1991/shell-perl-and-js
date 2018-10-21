#!/bin/sh
# egrep -A 11 "1993\|1993" t|tail -n +3
for((y=1993;y<=2016;y++))
do
  echo $y************************************************
  for((line=1;line<=10;line++))
  do
    name=$(wget -q -O- 'https://en.wikipedia.org/wiki/Triple_J_Hottest_100?action=raw'|egrep -A 11 "$y\|$y"|tail -n +3|sed -n "$line"p|sed 's/#//'|sed 's/([^\)]*)//g'|sed 's/\[//g'|sed 's/\"//g'|sed 's/|.*]] //'|\
    sed 's/|.*]]//'|sed 's/\]//g')
    nf=$(echo $name|sed 's/ – /\t/'|sed 's/– /\t/'|cut -f1|sed 's/^ //')
    nl=$(echo $name|sed 's/ – /\t/'|sed 's/– /\t/'|cut -f2|sed 's/^ //')
    fn=$(echo "$line - $nl - $nf.mp3")
    echo "$fn"
  done
done

#wget -q -O- 'https://en.wikipedia.org/wiki/Triple_J_Hottest_100?action=raw'|egrep -A 11 "1995\|1995"
