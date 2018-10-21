#!/bin/sh
f="$*"
p=$(echo "$f"|cut -d'/' -f1)
i=$(id3 -l "$p"/*/*.mp3|egrep ".mp3"|wc -l)
for((na=1;na<=$i;na++))
do
  er=$(id3 -l "$p"/*/*.mp3|egrep ".mp3"|sed -n "$na"p)
  tit=$(echo $er|sed  's/ - /\t/g'|cut -f2)
  y=$(echo $er|egrep -o ", [0-9]{4}/[0-9]+"|cut -c3-6)
  t=$(echo $er|cut -d'/' -f3|sed 's/ -.*//')
  a=$(echo $er|sed 's/ - /\t/g'|cut -f3|sed 's/\.mp3://')
  alb=$(echo $er|cut -d'/' -f2)
  name=$(echo $er|sed 's/\.mp3:/\.mp3/')
  id3 -t "$tit" "$name">/dev/null
  id3 -T "$t" "$name">/dev/null
  id3 -a "$a" "$name">/dev/null
  id3 -A "$alb" "$name">/dev/null
  id3 -y "$y" "$name">/dev/null
done  
