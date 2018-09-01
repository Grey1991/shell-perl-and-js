#!/bin/sh
if test $# = 1
then
	pattern=$1
else
	echo "Usage: $0 <COURSE PREFIX>"
	exit 1
fi 

alpha=${pattern:0:1}

wget -q -O- "http://www.handbook.unsw.edu.au/vbook2017/brCoursesByAtoZ.jsp?StudyLevel=Undergraduate&descr=$alpha"|grep $pattern |cut -f9-|egrep -o "2017/.*</A"|sed s/"\.html\">"/" "/g|cut -c6-|sed -e s/"<\/A"//g|sed -e s/" $"//g>tmp5147182
wget -q -O- "http://www.handbook.unsw.edu.au/vbook2017/brCoursesByAtoZ.jsp?StudyLevel=Postgraduate&descr=$alpha"|grep $pattern |cut -f9-|egrep -o "2017/.*</A"|sed s/"\.html\">"/" "/g|cut -c6-|sed -e s/"<\/A"//g|sed -e s/" $"//g>>tmp5147182
cat tmp5147182|sort|uniq
rm tmp5147182 2>/dev/null