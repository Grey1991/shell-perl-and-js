#!/usr/bin/python3
import sys
num = sys.argv[1]
flag = False
d = dict()
count=0
while True:
	
	line = sys.stdin.readline()
	if line == '': break
	count+=1
	line = line.replace(" ","")
	line = line.lower()
	if line not in d:
		d[line] = 1
	else:
		d[line] += 1
	if len(d) == int(num):
		print("{} distinct lines seen after {} lines read.".format(num,count))			
		flag = True
		break
if not flag:
	print("End of input reached after {} lines read - {} different lines not seen.".format(count,num))
