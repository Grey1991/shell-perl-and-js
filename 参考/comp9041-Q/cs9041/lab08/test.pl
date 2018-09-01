#!/usr/bin/perl -w
# $x = "asdf ,sdfasdf:sdf";
# @a = split /fa/,$x;
# print join "|",@a;
$a = "Tue";
$b = "18";

$data{$a}{$b} = 1;
print "$data{Tue}{18}";