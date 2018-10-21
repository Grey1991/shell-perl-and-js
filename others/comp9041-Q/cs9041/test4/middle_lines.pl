#!/usr/bin/python3
import sys
file = sys.argv[1]
with open(file) as f:
	lines = f.readlines()
	if lines:
		if len(lines) % 2 == 1:
			print(lines[(len(lines)+1)//2 -1],end='')
		else:
			print(lines[(len(lines)+1)//2 - 1],end='')
			print(lines[(len(lines)+1)//2],end='')
