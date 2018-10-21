#!/usr/bin/perl -w

if (@ARGV != 2){
	print "Usage: $0 <number of lines> <string>","\n";
	exit 1;
}


$num = $ARGV[0];
$line = $ARGV[1];

if (not $num =~ m/^\d+$/){
	print "$0: argument 1 must be a non-negative integer","\n";
	exit 1;
}
$i = 0;
while ($i < $num) {
	print $line,"\n";
	$i++;
}