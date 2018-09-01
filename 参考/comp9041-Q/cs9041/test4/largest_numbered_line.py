#!/usr/bin/python3
import sys,re
m = list()
lines=list()
while True:
  line = sys.stdin.readline()
  if line == '': break

  nums = re.findall("-?\d+(?:\.\d+)?",line)
  print(nums)
  if nums:
      nums = sorted(nums, key=lambda x:float(x),reverse=True)
      m.append(nums[0])
      lines.append(line)
tmp = sorted(m,key=lambda x:float(x),reverse=True)
for i in range(len(lines)):
    if m[i] == tmp[0]:
        print(lines[i],end='')
