#!/usr/bin/python3
import sys
d = dict()
while True:
	line = sys.stdin.readline()
	line = line.strip()
	if line in d:
		d[line]+=1
	else:
		d[line]=1
	if d[line] == int(sys.argv[1]):
		print("Snap: "+line)
		break;

