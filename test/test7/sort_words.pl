#!/usr/bin/perl -w
while ($line = <>) {
  chomp $line;
  @result = sort(split / +/, $line);
  print join " ", @result;
  print "\n";
}
