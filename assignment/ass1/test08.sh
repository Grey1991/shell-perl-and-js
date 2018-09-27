#!/bin/sh
# rm errors
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
./legit.pl add b c d
echo 9 >b
./legit.pl rm a
# legit.pl: error: 'a' in repository is different to working file
./legit.pl rm b
# legit.pl: error: 'b' in index is different to both working file and repository
./legit.pl rm c
# legit.pl: error: 'c' has changes staged in the index
./legit.pl rm d
# legit.pl: error: 'd' has changes staged in the index
./legit.pl rm e
# legit.pl: error: 'e' is not in the legit repository
./legit.pl rm --cached a
./legit.pl rm --cached b
# legit.pl: error: 'b' in index is different to both working file and repository
./legit.pl rm --cached c
./legit.pl rm --cached d
./legit.pl rm --cached e
# legit.pl: error: 'e' is not in the legit repository
./legit.pl rm --force a
# legit.pl: error: 'a' is not in the legit repository
./legit.pl rm --force b
./legit.pl rm --force c
# legit.pl: error: 'c' is not in the legit repository
./legit.pl rm --force d
# legit.pl: error: 'd' is not in the legit repository
./legit.pl rm --force e
# legit.pl: error: 'e' is not in the legit repository
