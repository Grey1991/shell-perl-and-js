#!/usr/bin/perl -w
# $target = shift @ARGV;
if ($ARGV[0] eq '-d'){
	$flag = 1;
	shift @ARGV;
}
elsif($ARGV[0] eq '-t'){
	$flag = 2;
	shift @ARGV;
}

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


if ($flag) {
	foreach $x (@answer){
		$x =~ /^([^:]*): (S[12]) (.*)/;
		$name = $1;
		$period = $2;
		@tmp = split /, /,$3;
		foreach $time (@tmp){
			$time =~ /^(Mon|Tue|Wed|Thu|Fri|Sat) 0?([1-9]?[0-9]):.....0?([1-9]?[0-9]):/;
			foreach $num ($2..($3-1)){
				$y = "$period $name $1 $num\n";
				if (!grep {$y eq $_} @d) {
					push @d,$y;
				}
			}
		}
	}
	# if ($flag == 1){
	print @d;
	# }
	# else{
		# foreach $element (@d){
		# 	@div = split / /,$element;
		# 	$sem = $div[0];
		# 	$day = $div[2];
		# 	$time = $div[3];
		# 	if ($sem eq "S1"){
		# 		$a{$day}{$time}++;
		# 	}
		# 	else{
		# 		$s2{$day}{$time}++;
		# 	}
		# }
		# foreach $t (9..20){
		# 	foreach $d ("Mon","Tue","Wen","Thu","Fri"){
		# 		if (!$a{$d}{$t}) {
		# 			$a{$d}{$t} = " ";
		# 		}
		# 		if (!$b{$d}{$t}) {
		# 			$b{$d}{$t} = " ";
		# 		}
		# 	}
		# }


		# print "S1       Mon   Tue   Wen   Thu   Fri\n";
		# print "09:00     $a{"Mon"}{"9"}     $a{"Tue"}{"9"}     $a{"Wen"}{"9"}     $a{"Thu"}{"9"}     $a{"Fri"}{"9"}\n";
		# foreach $i (10..20){
		# 	print "$i:00     $a{"Mon"}{$i}     $a{"Tue"}{$i}     $a{"Wen"}{$i}     $a{"Thu"}{$i}     $a{"Fri"}{$i}\n";
		# }
	# }
	

}
else{
	print @answer;
}