#!/usr/bin/perl -w
open(FILE,">",$ARGV[2]);
for ($i = $ARGV[0];$i <= $ARGV[1];$i++) {
  print FILE "$i\n";
}
close FILE;
