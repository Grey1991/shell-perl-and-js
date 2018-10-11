#!/usr/bin/perl -w
@arr =  sort {$a <=> $b} (@ARGV);
print $arr[$#arr / 2],"\n";