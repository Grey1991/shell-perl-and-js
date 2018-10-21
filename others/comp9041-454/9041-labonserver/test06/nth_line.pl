#!/usr/bin/perl -w
open F, '<', "$ARGV[1]" or die;
$i=0;
while ($line=<F>){
  $i++;
  if ($i==$ARGV[0]){
    printf $line;
  }
}
