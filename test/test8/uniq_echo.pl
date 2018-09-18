#!/usr/bin/perl -w
%uniq = ();
foreach $arg (@ARGV) {
  if (!$uniq{$arg}) {
    print "$arg ";
    $uniq{$arg} = 1;
  }
}
print "\n";
