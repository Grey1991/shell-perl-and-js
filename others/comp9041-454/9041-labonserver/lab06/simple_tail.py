#!/usr/bin/python
from sys import *
for ni in range(1,len(argv)):
    name=argv[ni]
    f=open(name,'r')
    data=f.readlines()
    start=len(data)-10
    if start<0:
        start=0
    for i in range(start,len(data)):
        print data[i],
    f.close()
