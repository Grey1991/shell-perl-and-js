#!/bin/sh

# test rm add
rm -rf .legit
./legit.pl init
# Initialized empty legit repository in .legit
touch a b
./legit.pl add a b
./legit.pl commit -m "first commit"
# Committed as commit 0
rm a
./legit.pl commit -m "second commit"
# nothing to commit
./legit.pl add a
./legit.pl commit -m "second commit"
# Committed as commit 1
./legit.pl rm --cached b
./legit.pl commit -m "second commit"
# Committed as commit 2
./legit.pl rm b
# legit.pl: error: 'b' is not in the legit repository
./legit.pl add b
./legit.pl rm b
# legit.pl: error: 'b' has changes staged in the index
./legit.pl commit -m "third commit"
# Committed as commit 3
./legit.pl rm b
./legit.pl commit -m "fourth commit"
# Committed as commit 4
