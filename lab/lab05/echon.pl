#!/usr/bin/perl -w
die "Usage: ./echon.pl <number of lines> <string>\n" if @ARGV != 2;
die "./echon.pl: argument 1 must be a non-negative integer\n" if $ARGV[0] !~ /^\d+$/;
for($i=1;$i<=$ARGV[0];$i++){
  printf "$ARGV[1]\n";
}
