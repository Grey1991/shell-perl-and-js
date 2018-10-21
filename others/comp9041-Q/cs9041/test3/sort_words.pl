#!/usr/bin/python3
import sys
lines = sys.stdin.readlines()
for line in lines:
	line = line.strip()
	l = line.split()
	print(" ".join(sorted(l)))
