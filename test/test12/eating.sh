#!/bin/sh
egrep ":" $1 | cut -d ',' -f1 | cut -d ':' -f2 |sed 's/^ \"//' |sed 's/\"//g'|sort|uniq