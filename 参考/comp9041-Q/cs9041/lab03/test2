#!/bin/sh
if test $# = 1
then
	pattern=$1
else
	echo "Usage: $0 <COURSE PREFIX>"
	exit 1
fi 
a=` wget -q -O- "http://www.handbook.unsw.edu.au/vbook2017/brCoursesByAtoZ.jsp?StudyLevel=Undergraduate&descr=O"|grep $pattern |cut -f9`