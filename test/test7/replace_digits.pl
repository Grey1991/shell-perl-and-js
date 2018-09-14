#!/usr/bin/perl -w
open FILE,"<",$ARGV[0] or die;
@arr = ();
while ($line = <FILE>) {
  $line =~ s/[0-9]/#/g;
  push @arr, $line;
}
close FILE;
open FILE,">",$ARGV[0] or die;
foreach $line (@arr) {
  print FILE $line;
}
close FILE;
