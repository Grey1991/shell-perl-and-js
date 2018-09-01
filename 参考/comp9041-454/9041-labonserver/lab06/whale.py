#!/usr/bin/python
from sys import *
from re import *
name=argv[1]
line=0
totnum=0
while 1:
    try:
        data=raw_input()
        m=search(r'{}'.format(name),data)
        if m:
            line+=1
            currnum=data.split(' ')[0]
            totnum=totnum+int(currnum)
    except:
        print("{} observations: {} pods, {} individuals".format(name,line,totnum))
        exit()
