#!/bin/sh
if test $# = 1
then
	pattern=$1
else
	echo "Usage: $0 <COURSE PREFIX>"
	exit 1
fi
#grap the first letter => COMP->C
alpha=${pattern:0:1}
Undergraduate="http://www.handbook.unsw.edu.au/vbook2018/brCoursesByAtoZ.jsp?StudyLevel=Undergraduate&descr=$alpha"
Postgraduate="http://www.handbook.unsw.edu.au/vbook2018/brCoursesByAtoZ.jsp?StudyLevel=Postgraduate&descr=$alpha"
wget -q -O- "$Undergraduate" "$Postgraduate"|grep $pattern |cut -f9-|egrep -o "2018/.*</A"|sed s/"\.html\">"/" "/g|cut -c6-|sed s/"<\/A"//g|sed s/" $"//g|sort|uniq
