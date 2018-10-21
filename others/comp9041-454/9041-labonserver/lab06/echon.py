#!/usr/bin/python
from sys import *
from re import *
if len(argv)!=3:
    print("Usage: ./echon.py <number of lines> <string>")
    exit()
try:
    num=int(argv[1])
except:
    print("./echon.py: argument 1 must be a non-negative integer")
    exit()
if num>=0:
    for i in range(0,num):
        print(argv[2])
else:
    print("./echon.py: argument 1 must be a non-negative integer")
    exit()
