#!/usr/bin/perl -w
$line = "1 42 12 4";
@num = split /[^1-9.]+/,$line;
print join "|",sort(@num);
