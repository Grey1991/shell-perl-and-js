#!/bin/sh
if test -f "shuffle.pl"
then
  i=0;while ((i < 10)); do echo $i; i=$((i + 1)); done|sort > temp1.txt
  i=0;while ((i < 10)); do echo $i; i=$((i + 1)); done|./shuffle.pl|sort > temp2.txt
  if diff temp1.txt temp2.txt >/dev/null
    then
      echo "passed"
  else
    echo -e "failed\n"
    diff temp1.txt temp2.txt
  fi
  rm temp1.txt temp2.txt
else
  echo "No such file shuffle.pl"
  exit
fi
