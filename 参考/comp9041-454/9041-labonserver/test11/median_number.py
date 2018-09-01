#!/usr/bin/python3
import sys
a = []
for i in range(1,len(sys.argv)):
    a.append(int(sys.argv[i]))
a = sorted(a)
index = int((len(a)-1)/2)
print(a[index])
