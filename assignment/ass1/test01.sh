#!/bin/sh

# # Test subset1_10 (add + commit -a)
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

# # Test subset1_10 (add + commit -a)
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


# # Test subset1_11 (rm) - failed (Incorrect output)
# rm -rf .legit
# ./legit.pl init
# echo 1 >a
# echo 2 >b
# ./legit.pl add a b
# ./legit.pl commit -m "first commit"
# echo 3 >c
# echo 4 >d
# ./legit.pl add c d
# ./legit.pl rm --cached  a c
# ./legit.pl commit -m "second commit"
# ./legit.pl show 0:a
# ./legit.pl show 1:a
# ./legit.pl show :a

# # Test subset1_13 (rm add) - failed (Incorrect output)
# rm -rf .legit
# ./legit.pl init
# # Initialized empty legit repository in .legit
# touch a b
# ./legit.pl add a b
# ./legit.pl commit -m "first commit"
# # Committed as commit 0
# rm a
# ./legit.pl commit -m "second commit"
# # nothing to commit
# ./legit.pl add a
# ./legit.pl commit -m "second commit"
# # Committed as commit 1
# ./legit.pl rm --cached b
# ./legit.pl commit -m "second commit"
# # Committed as commit 2
# ./legit.pl rm b
# # legit.pl: error: 'b' is not in the legit repository
# ./legit.pl add b
# ./legit.pl rm b
# # legit.pl: error: 'b' has changes staged in the index
# ./legit.pl commit -m "third commit"
# # Committed as commit 3
# ./legit.pl rm b
# ./legit.pl commit -m "fourth commit"
# # Committed as commit 4
