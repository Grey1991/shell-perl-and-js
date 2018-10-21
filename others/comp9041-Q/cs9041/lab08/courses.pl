#!/usr/bin/perl -w
$target = "COMP9024";
$url = "http://www.timetable.unsw.edu.au/current/$target"."KENS.html";
open F, "wget -q -O- $url|" or die;
while ($line = <F>) {
	if ($line =~ /($target\d{4})/i){
		if (!grep {$1 eq $_} @arr){
			push @arr,$1;
		}
	}
}
print join "\n",@arr;
print "\n";
