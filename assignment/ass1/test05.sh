#!/bin/sh

# # Test subset1_11 (rm) - failed (Incorrect output)
rm -rf .legit
./legit.pl init
echo 1 >a
echo 2 >b
./legit.pl add a b
./legit.pl commit -m "first commit"
echo 3 >c
echo 4 >d
./legit.pl add c d
./legit.pl rm --cached  a c
./legit.pl commit -m "second commit"
./legit.pl show 0:a
./legit.pl show 1:a
./legit.pl show :a
