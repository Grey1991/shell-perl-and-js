#!/usr/bin/python3
import sys
num = int(sys.argv[1])
file = sys.argv[2]
with open(file,'r') as f:
	lines = f.readlines()
if len(lines) >= num and num != 0:
	print(lines[num-1],end='')
