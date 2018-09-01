#!/usr/bin/perl -w
$num = 10;


if (@ARGV >= 1 and $ARGV[0] =~ m/^-\d+$/) {
	$num = shift @ARGV;
	$num =~ s/\-//;
	
}

if (@ARGV == 0){
	@lines = <>;
	$start = $#lines+1 - $num;
	if ($start>=0) {
		print @lines[$start..$#lines];
	}
	else{
		print @lines;
	}
}

if (@ARGV == 1) {
	$file = $ARGV[0];
	open FILE, '<',$file or die "$0: can't open $file\n";
	@lines = <FILE>;
	$start = $#lines+1 - $num;
	if ($start>=0) {
		print @lines[$start..$#lines];
	}
	else{
		print @lines;
	}
	close FILE;
}
else{
	foreach $file (@ARGV){
		open FILE, '<', $file or die "$0: can't open $file\n";
		@lines = <FILE>;
		print "==> $file <==\n";
		$start = $#lines+1 - $num;
		if ($start>=0) {
			print @lines[$start..$#lines];
		}
		else{
			print @lines;
		}
		close FILE;
	}
}