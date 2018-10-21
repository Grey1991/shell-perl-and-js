#!/usr/bin/python
from re import *
import sys

while True:
    try:
        c=raw_input()
        d=sub(r'[0-4]','<',c)
        d=sub(r'[6-9]','>',d)
        print(d)
    except:
        sys.exit()
