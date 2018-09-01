#!/usr/bin/perl -w
while($line = <>){
	@arr = $line =~ /[a-zA-Z]+/g;
	$tmp = 0;
	foreach $x (@arr){
		if ($x){
			$tmp++;
		}
	}
	$count += $tmp;
	# print $tmp," $count";
	# print join":",@arr,"\n";
}
print $count," words\n";