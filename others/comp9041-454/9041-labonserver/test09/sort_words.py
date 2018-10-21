#!/usr/bin/python
import sys
for line in sys.stdin:
    line_list=line.split()
    line_list=sorted(line_list)
    for i in line_list:
        print(i),
    print("\n"),
