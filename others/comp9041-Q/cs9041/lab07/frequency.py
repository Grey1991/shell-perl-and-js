#!/usr/bin/python3
import re,sys
from math import *
import glob
word = sys.argv[1]
d = {}
for file in glob.glob("lyrics/*.txt"):
	name = re.sub('_',' ',file[7:-4])
	a = open(file).readlines()
	sum = 0
	word_sum = 0
	for line in a:
		l = re.split(r'[^a-zA-Z]',line)
		for x in l:
			if x:
				sum+=1
			if x.lower() == word.lower():
				word_sum += 1
	d[name] = (word_sum,sum)


for n in sorted(d.keys()):
	# print (n)
	print ("{:4d}/ {:6d} = {:.9f} {}".format(d[n][0],d[n][1],(d[n][0])/d[n][1],n))
    
    