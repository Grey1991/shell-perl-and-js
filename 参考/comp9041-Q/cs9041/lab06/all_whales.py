#!/usr/bin/python3
from collections import defaultdict
import re,sys
a = defaultdict(list)
b= []
while True:
	s = sys.stdin.readline()
	if not s:
		break
	s=s.strip()
	match = re.match(r'^(\d+) (.*)$',s)
	try:
		num = match.group(1)
		# print(num)
		name = match.group(2)
		name = name.lower()
		if name[-1] == 's':
			name = name[:-1]
		name = ' '.join(name.split())
	except:
		pass
	a[name].append(int(num))
# 	b.append(name)
# b.sort()
for key in sorted(a):
	print("{} observations: {} pods, {} individuals"\
		.format(key,len(a[key]),sum(a[key])))