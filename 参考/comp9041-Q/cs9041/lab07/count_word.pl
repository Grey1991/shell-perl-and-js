#!/usr/bin/perl -w
$ori_word = shift @ARGV;
# print $ori_word;
$word = uc $ori_word;
# print $word,"\n";
$count = 0;
while($line = <>){
	@arr = $line =~ /[a-zA-Z]+/g;
	# $tmp = 0;
	foreach $x (@arr){
		chomp $x;

		$up = uc $x;
		# print $x,",",$up,"|";
		if ($up eq $word){
			$count++;
		}
	}
	# $count += $tmp;
	# print $tmp," $count";
	# print join":",@arr,"\n";
}
print "$ori_word occurred $count times","\n";


