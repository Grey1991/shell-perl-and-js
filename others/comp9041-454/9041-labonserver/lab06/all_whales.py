#!/usr/bin/python
from sys import *
from re import *
wi={}
wl={}
while 1:
    try:
        data=raw_input()
        data=data.lower()
        data=sub(' +',' ',data)
        data=sub('^ ','',data)
        data=sub(' $','',data)
        data=sub('s$','',data)
        data=sub(' ','=',data,1)
        wa=data.split('=')[1]
        wn=int(data.split('=')[0])
        if wa not in wi:
            wi[wa]=wn
        else:
            wi[wa]+=wn
        if wa not in wl:
            wl[wa]=1
        else:
            wl[wa]+=1
    except:
        wk=sorted(wi.keys())
        for key in wk:
            print('{} observations: {} pods, {} individuals'.format(key,wl[key],wi[key]))
        exit()
