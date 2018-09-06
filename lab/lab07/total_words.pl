#!/usr/bin/perl -w
$total_words = 0;
while ($line = <>) {
  @words = $line =~ /[a-zA-Z]+/g;
  $total_words += @words;
}
print "$total_words words\n";
