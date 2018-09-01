#!/usr/bin/python3
import sys,re
need_test = sys.argv[1]
test_list = []
test_list2 = []
for i in range(0,len(need_test)):
    if re.match(r'[a-z]',need_test[i].lower()):
        test_list.append(need_test[i].lower())
        test_list2.append(need_test[i].lower())
test_list.reverse()
if test_list==test_list2:
    print("True")
else:
    print("False")
