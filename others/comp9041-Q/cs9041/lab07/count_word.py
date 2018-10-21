#!/usr/bin/python3
import re,sys
sum = 0
word = sys.argv[1]
for line in sys.stdin:
    l = re.split(r'[^a-zA-Z]',line)
    new_l = []
    for x in l:
    	if x.lower() == word.lower():
    		new_l.append(x)
    sum += len(new_l)
print("{} occurred ".format(word),end='')
print(sum,end='')
print(" times")