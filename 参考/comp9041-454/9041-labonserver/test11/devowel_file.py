#!/usr/bin/python3
import sys,re
name = sys.argv[1]
f = open(name,'r')
data = f.readlines()
f.close()
f = open(name,'w')
for each in data:
    each = re.sub('[AEIOUaeiou]','',each)
    print(each,end='',file=f)
f.close()
