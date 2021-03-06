#!/usr/bin/perl -w
$target = lc $ARGV[0];
%count = ();
%total = ();

foreach $file (glob "lyrics/*.txt") {
  $word_count = 0;
  $total_count = 0;
  open FILE, "<", $file or die;
  while ($line = <FILE>) {
      @words = $line =~ /[a-zA-Z]+/g;
      foreach $word (@words) {
        $word_count++ if lc $word eq $target;
        $total_count++;
      }
  }
  $file =~ s/.*\///;
  $file =~ s/.txt//;
  $file =~ s/_/ /g;
  $count{$file} = $word_count;
  $total{$file} = $total_count;
}

foreach $key (sort keys %count) {
  printf "log((%d+1)/%6d) = %8.4f %s\n",$count{$key},$total{$key},log(($count{$key}+1)/$total{$key}),$key;
}
