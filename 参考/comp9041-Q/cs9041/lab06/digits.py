#!/usr/bin/python3
import re,sys
while True:
	a = sys.stdin.readline()
	if not a:
		break
	a = re.sub('[01234]','<',a)
	a = re.sub('[6789]','>',a)
	print (a,end = '')
