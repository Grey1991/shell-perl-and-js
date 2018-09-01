#!/usr/bin/perl -w
$num = shift @ARGV;
while ($line = <>){
	chomp $line;
	if ($data{$line}){
		$data{$line}++;
	}
	else{
		$data{$line} = '1';
	}
	if ($data{$line} == $num){
		print "Snap: $line","\n";
		last;
	}
}
