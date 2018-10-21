#!/usr/bin/python
import sys
import re
import glob
import math
word=sys.argv[1]
cw={}
ct={}
word_len=0
tot_len=0
file_list=glob.glob(r"lyrics/*.txt")
for filename in file_list:
    with open(filename) as file:
        data = file.read()
        list=re.findall(r'\b{}\b'.format(word),data,flags=re.IGNORECASE)
        word_len=len(list)
        list2=re.findall(r'[a-zA-Z]+',data)
        tot_len=len(list2)
        filename=re.sub(r'.*/','',filename)
        filename=re.sub(r'.txt','',filename)
        filename=re.sub(r'[^a-z]',' ',filename,flags=re.IGNORECASE)
        cw[filename]=word_len
        ct[filename]=tot_len

for i in sorted(cw.keys()):
    print "log((%d+1)/%6d) = %8.4f %s" % (cw[i],ct[i],math.log(float(cw[i]+1)/float(ct[i])),i)
