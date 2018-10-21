#!/bin/sh
egrep "COMP[29]041" "$@"|egrep -o ", [^\|]*"|sed 's/ *$//'|sed 's/, //'|cut -d' ' -f1|sort|uniq -c|sort|tail -n 1|egrep -i -o [a-z]+
