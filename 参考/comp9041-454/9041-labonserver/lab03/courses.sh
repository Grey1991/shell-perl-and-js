#!/bin/sh
(wget -q -O- "http://www.handbook.unsw.edu.au/vbook2017/brCoursesByAtoZ.jsp?StudyLevel=Undergraduate&descr=All" \
|egrep -o "$1[0-9]{4}.html\">.*</A></TD>" |sed 's/ <\/A><\/TD>//' |sed 's/<\/A><\/TD>//' |sed 's/.html\">/ /' && \
wget -q -O- "http://www.handbook.unsw.edu.au/vbook2017/brCoursesByAtoZ.jsp?StudyLevel=Postgraduate&descr=All" \
|egrep -o "$1[0-9]{4}.html\">.*</A></TD>" |sed 's/ <\/A><\/TD>//' |sed 's/<\/A><\/TD>//' |sed 's/.html\">/ /') |sort|uniq|sort
