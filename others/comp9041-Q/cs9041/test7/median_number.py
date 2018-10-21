#!/usr/bin/python3
import sys
nums = sorted(sys.argv[1:],key = lambda x:int(x))
print(nums[len(nums)//2])





















# import math,sys
# l = sys.argv[1:]
# for i in range(len(l)):
#     l[i] = int(l[i])
# l.sort();
# print(l[len(l)//2])
