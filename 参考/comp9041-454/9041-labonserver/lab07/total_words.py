#!/usr/bin/python
import sys
import re
tot_len=0
for line in sys.stdin:
    list=re.findall(r'[a-zA-Z]+',line)
    tot_len+=len(list)
print('{} words'.format(tot_len))
