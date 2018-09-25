#!/bin/sh
rm -rf .legit
./legit.pl init
./legit.pl add non_existent_file
echo 1 >a
./legit.pl add a
echo 2 >a
./legit.pl commit -m message
echo 3 >a
./legit.pl show 0:a
./legit.pl show :a
