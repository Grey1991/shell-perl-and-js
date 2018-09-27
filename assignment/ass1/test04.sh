#!/bin/sh
# test add commit no change commit
rm -rf .legit
./legit.pl init
# Initialized empty legit repository in .legit
echo 1 >a
./legit.pl add a
./legit.pl commit -m message1
# Committed as commit 0
touch a
./legit.pl add a
./legit.pl commit -m message2
# nothing to commit
