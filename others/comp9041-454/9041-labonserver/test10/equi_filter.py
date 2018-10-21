#!/usr/bin/python3
import sys
flag=0
need_printlist=[]
for line in sys.stdin:
    line_list=line.split()
    for word in line_list:
        char_occ={}
        occ_times=[]
        char_list=[]
        for single_char in range(0,len(word)):
            char_list.append(word[single_char])
        for char in char_list:
            char=char.lower()
            if char in char_occ:
                char_occ[char]+=1
            else:
                char_occ[char]=1
        for char_key in char_occ.keys():
            occ_times.append(char_occ[char_key])
        first_ele=occ_times[0]
        for occ in occ_times:
            if occ!=first_ele:
                flag=1
                break
        if flag==0:
            need_printlist.append(word)
            need_printlist.append(" ")
        else:
            flag=0
    need_printlist.append("\n")
for i in need_printlist:
    print(i,end='')
