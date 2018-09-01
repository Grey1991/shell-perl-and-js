#!/usr/bin/python3
# The function re.split or the function re.findall could be used to separate words. 
import re,sys
sum = 0
for line in sys.stdin:
    l = re.split(r'[^a-zA-Z]',line)
    new_l = []
    for x in l:
    	if x:
    		new_l.append(x)
    sum += len(new_l)
print(sum,end='')
print(" words")