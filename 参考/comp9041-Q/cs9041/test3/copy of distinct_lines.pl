#!/usr/bin/perl -w
$num = shift @ARGV;
# @arr = ();
$x = 0;
$count = 0;
while ($line = <>) {
	$count++;
	$line =~ tr/[A-Z]/[a-z]/;
	$line =~ tr/" "//s;
	$line =~ s/ //g;
	$data{$line}++;
	@a = keys %data;
	if ($#a == ($num-1)){
		$x = 1;
		last;
	}
}


if ($x){
	print "$num distinct lines seen after $count lines read.\n";
}
else{
	print "End of input reached after $count lines read - $num different lines not seen.\n"
}
