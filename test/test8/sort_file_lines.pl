#!/usr/bin/perl -w
%content_length = ();
$i = 0;
while ($line = <>) {
  $content_length{$i} = [length($line),$line];
  $i++;
}
@content = sort {$content_length{$a}[0] <=> $content_length{$b}[0] || $content_length{$a}[1] cmp $content_length{$b}[1]} keys %content_length;
foreach $key (@content) {
  print $content_length{$key}[1];
}
