#!/bin/sh

egrep COMP[29]041 $1|sort -u -t'|' -k2|cut -d'|' -f3|cut -d',' -f2|cut -d' ' -f2|sort|uniq -c|sort -n|tail -1|egrep -oi '[a-z]*'

