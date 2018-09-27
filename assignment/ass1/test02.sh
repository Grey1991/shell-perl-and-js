#!/bin/sh
# test add commit log show
rm -rf .legit
./legit.pl init
# Initialized empty legit repository in .legit
echo line 1 >a
echo hello world >b
./legit.pl add a b
./legit.pl commit -m "first commit"
# Committed as commit 0
echo line 2 >>a
./legit.pl add a
./legit.pl commit -m "second commit"
# Committed as commit 1
./legit.pl log
# 1 second commit
# 0 first commit
echo line 3 >>a
./legit.pl add a
echo line 4 >>a
./legit.pl show 0:a
# line 1
./legit.pl show 1:a
# line 1
# line 2
./legit.pl show :a
# line 1
# line 2
# line 3
./legit.pl show 0:b
# hello world
./legit.pl show 1:b
# hello world
