#!/usr/bin/python3
from collections import defaultdict
import re,sys
a = defaultdict(list)
while True:
	s = sys.stdin.readline()
	if not s:
		break
	match = re.match(r'^(\d+) (.*)$',s)
	try:
		num = match.group(1)
		# print(num)
		name = match.group(2)
	except:
		pass
	a[name].append(int(num))
print("{} observations: {} pods, {} individuals"\
	.format(sys.argv[1],len(a[sys.argv[1]]),sum(a[sys.argv[1]])))