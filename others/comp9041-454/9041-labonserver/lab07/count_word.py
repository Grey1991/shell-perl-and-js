#!/usr/bin/python
import sys
import re
word=sys.argv[1]
word_len=0
for line in sys.stdin:
    list=re.findall(r'\b{}\b'.format(word),line,flags=re.IGNORECASE)
    word_len+=len(list)
print('{} occurred {} times'.format(word,word_len))
