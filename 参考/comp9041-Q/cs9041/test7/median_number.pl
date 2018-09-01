#!/usr/bin/perl -w
@arr =  sort {$a <=> $b} (@ARGV);
print $arr[$#arr / 2],"\n";




















# while (@ARGV) {
#   $num = shift @ARGV;
#   chomp $num;
#   push @arr,$num;
# }
# @arr = sort {$a <=> $b} @arr;
# $i = int($#arr / 2);
# print "$arr[$i]\n";

# print join "|",@arr;
