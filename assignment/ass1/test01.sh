#!/bin/sh

# Test subset1_10 (add + commit -a)
# rm -rf .legit
# ./legit.pl init
# echo line 1 >a
# ./legit.pl add a
# ./legit.pl commit -m "first commit"
# echo line 2 >>a
# echo world >b
# ./legit.pl add b
# ./legit.pl commit -a -m "second commit"
# ./legit.pl show 1:a
# ./legit.pl show 1:b

# Test subset1_10 (add + commit -a)
rm -rf .legit
./legit.pl init
echo line 1 >a
./legit.pl add a
./legit.pl commit -m "first commit"
echo line 2 >>a
echo world >b
./legit.pl add b
./legit.pl commit -a -m "second commit"
./legit.pl show 1:a
./legit.pl show 1:b
