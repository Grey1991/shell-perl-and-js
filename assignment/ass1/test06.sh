#!/bin/sh
# test add + commit -a
rm -rf .legit
./legit.pl init
# Initialized empty legit repository in .legit
echo line 1 >a
./legit.pl add a
./legit.pl commit -m "first commit"
# Committed as commit 0
echo line 2 >>a
echo world >b
./legit.pl add b
./legit.pl commit -a -m "second commit"
# Committed as commit 1
./legit.pl show 1:a
# line 1
# line 2
./legit.pl show 1:b
# world
