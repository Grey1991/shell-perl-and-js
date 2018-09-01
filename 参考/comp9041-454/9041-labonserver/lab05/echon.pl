#!/usr/bin/perl -w
die "Usage: ./echon.pl <number of lines> <string>\n" if @ARGV != 2;
if ($ARGV[0] !~ /^[^-0][0-9]*$|^0$/){
  die "./echon.pl: argument 1 must be a non-negative integer\n";
}
for($i=1;$i<=$ARGV[0];$i++){
  printf "$ARGV[1]\n";
}
