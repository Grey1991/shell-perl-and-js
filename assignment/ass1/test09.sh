#!/bin/sh
# test rm options
rm -rf .legit
./legit.pl init
# Initialized empty legit repository in .legit
echo 1 >a
echo 2 >b
echo 3 >c
./legit.pl add a b c
./legit.pl commit -m "first commit"
# Committed as commit 0
echo 4 >>a
echo 5 >>b
echo 6 >>c
echo 7 >d
echo 8 >e
./legit.pl add b c d e
echo 9 >b
echo 0 >d
./legit.pl rm --cached a c
./legit.pl rm --force --cached b
./legit.pl rm --cached --force e
./legit.pl rm --force d
./legit.pl status
# a - untracked
# b - untracked
# c - untracked
# e - untracked

echo "test for status"
# test for status
rm -rf .legit
./legit.pl init
# Initialized empty legit repository in .legit
touch a b c d e f g h
./legit.pl add a b c d e f
./legit.pl commit -m "first commit"
# Committed as commit 0
echo hello >a
echo hello >b
echo hello >c
./legit.pl add a b
echo world >a
rm d
./legit.pl rm e
./legit.pl add g
./legit.pl status
# a - file changed, different changes staged for commit
# b - file changed, changes staged for commit
# c - file changed, changes not staged for commit
# d - file deleted
# e - deleted
# f - same as repo
# g - added to index
# h - untracked
