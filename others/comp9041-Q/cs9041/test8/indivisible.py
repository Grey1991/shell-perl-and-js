#!/usr/bin/python3
import sys
def check(i,all_num):
    for x in all_num[i+1:]:
        if all_num[i] % x == 0 :
            return False
    return True

all_num = []
while True:
    line = sys.stdin.readline()
    if not line: break
    nums = [int(x) for x in line.split()]
    all_num += nums
all_num = sorted(all_num,reverse=True)
answer = [str(all_num[i]) for i in range(len(all_num)) if check(i,all_num)]
print(' '.join(answer[::-1]))
