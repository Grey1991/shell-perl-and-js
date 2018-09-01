#!/usr/bin/python3
import sys, re
filename = sys.argv[1]
with open(filename) as f:
    l = [re.sub("[aeiou]","",line,flags=re.I) for line in f.readlines()]
with open(filename,'w') as f:
    for line in l:
        f.write(line)




















# import sys,re
# filename = sys.argv[1]
# with open (filename) as f:
#     l = f.readlines()
# for i in range(len(l)):
#     l[i] = re.sub('[aeiou]',"",l[i],flags=re.I)
# with open (filename,'w') as f:
#     for line in l:
#         f.write(line)
