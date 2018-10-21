#!/usr/bin/python
import sys
import re
d_l=int(sys.argv[1])
a=set()
i=0
flag=0
while 1:
    try:
        line=raw_input()
    except:
        flag=1
        break
    line=re.sub(r'^\s+','',line)
    line=re.sub(r'\s+$','',line)
    line=re.sub(r' +',' ',line)
    line=line.lower()
    i+=1
    a.add(line)
    if len(a)==d_l:
        break
if flag==0:
    print("{} distinct lines seen after {} lines read.".format(d_l,i))
if flag==1:
    print("End of input reached after {} lines read -  {} different lines not seen.".format(i,d_l))
