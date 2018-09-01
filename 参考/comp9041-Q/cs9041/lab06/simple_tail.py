#!/usr/bin/python3
from sys import *
for x in argv[1:]:
	try:
		a = open(x).readlines()
		if len(a)>=10:
			for line in a[-10:]:
				print (line,end='')
		else:
			for line in a:
				print(line,end='')
	except:
		print('No such file')
