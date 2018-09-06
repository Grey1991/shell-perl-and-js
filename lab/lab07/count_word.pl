#!/usr/bin/perl -w
$target = lc $ARGV[0];
$count = 0;
while ($line = <STDIN>) {
  @arr = $line =~ /[a-zA-Z]+/ig;
  foreach $word (@arr) {
    $count++ if lc $word eq $target;
  }
}
print "$target occurred $count times\n";
