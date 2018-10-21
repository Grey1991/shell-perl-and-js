#!/usr/bin/python
import sys
a=set()
for line in sys.argv[1:]:
    a.add(line)
for n in sys.argv[1:]:
    if n in a:
        print(n),
        a.remove(n)
