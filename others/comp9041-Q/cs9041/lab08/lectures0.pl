#!/usr/bin/perl -w
# $target = shift @ARGV;
while(@ARGV){
	$target = shift @ARGV;
	$url = "http://timetable.unsw.edu.au/current/$target.html";
	open F, "wget -q -O- $url|" or die;
	@arr=();
	while ($line = <F>) {
		push @arr,$line;
	}

	foreach $i (0..$#arr){
		if ($arr[$i] =~ /Lecture/i){
			# print $arr[$i + 6];
			if ($arr[$i+6] =~ /((Mon|Tue|Wed|Thu|Fri|Sat)[^<]*)/) {
				$time = $1;
				$arr[$i+1] =~ /(T[12])/;
				$period = $1;
				$period =~ s/T/S/;
				$x = "$target: $period $time\n";
				if (!grep {$x eq $_} @answer) {
					push @answer,$x;
				}
				
			}
			# print"$arr[$i+1]","$arr[$i+7]";
		}
	}
}
print @answer;