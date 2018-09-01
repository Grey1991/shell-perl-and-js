#!/usr/bin/perl -w
@arr = ();
while($word = shift @ARGV){
	$flag = 1;
	foreach $x (@arr){
		if ($word eq $x){
			$flag = 0;
			last;
		}
	}
	if ($flag){
		push @arr,$word;
	}

}
print join" ",@arr,"\n";
