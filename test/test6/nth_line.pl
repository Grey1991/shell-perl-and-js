#!/usr/bin/perl -w
open(FILE, "<", $ARGV[1]) or die;
$i = 1;
while ($line = <FILE>) {
  if ($i == $ARGV[0]) {
    print $line;
  }
  $i++;
}
