#!/usr/bin/python3
from sys import *


if len(argv)!=3:
	print("Usage: {} <number of lines> <string>".format(argv[0]))
	exit()
if not argv[1].isdigit() or int(argv[1])!=float(argv[1]):
	print("{}: argument 1 must be a non-negative integer".format(argv[0]))
	exit()
for i in range(int(argv[1])):
	print(argv[2])