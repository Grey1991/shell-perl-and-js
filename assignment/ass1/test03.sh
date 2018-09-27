#!/bin/sh
# test show errors
rm -rf .legit
./legit.pl init
# Initialized empty legit repository in .legit
echo line 1 >a
echo hello world >b
./legit.pl add a b
./legit.pl commit -m "first commit"
# Committed as commit 0
./legit.pl show :c
# legit.pl: error: 'c' not found in index
./legit.pl show 0:c
# legit.pl: error: 'c' not found in commit 0
./legit.pl show 2:a
# legit.pl: error: unknown commit '2'
