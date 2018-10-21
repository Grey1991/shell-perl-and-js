#!/usr/bin/python3
import sys,re
lines = sys.stdin.readlines()
for line in lines:
	print(re.sub("\d",'',line),end="")
