#!/usr/bin/python3
import sys,re
def check(word):
    word = word.lower()
    for c in word:
        if word.count(c) != word.count(word[0]):
            return False
    return True

while True:
    line = sys.stdin.readline()
    if not line: break
    words = re.split("\s+",line.strip())
    answer = [word for word in words if check(word)]
    print(" ".join(answer))



















# import sys
# from collections import defaultdict
# for line in sys.stdin:
#     answer = []
#     l = line.split()
#     for word in l:
#         flag = 1
#         count = defaultdict(list)
#         for x in word:
#             count[x.lower()].append(1)
#         value = list(count.values())
#         for i in range(1,len(value)):
#             if value[i] != value[i-1]:
#                 flag = 0
#         if flag:
#             answer.append(word)
#     # print(answer)
#     print (" ".join(answer))
