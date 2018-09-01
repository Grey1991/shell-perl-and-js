#!/usr/bin/perl -w
# if ($ARGV[0] eq "-d") {
# 	$file = $ARGV[2]
# }
foreach $file (glob "lyrics/*.txt") {
	$name = $file;
	$name =~ s/^[^\/]*\///;
	$name =~ s/\.txt$//;
	$name =~ tr/_/ /;
	push @name_arr,$name;

	open F,'<',$file;
	while ($line = <F>){
		@arr = $line =~ /[a-zA-Z]+/g;
		foreach $x (@arr){
			chomp $x;
			if ($x){
				$x = uc $x;
				$data{$name}{$x}++;
				$count{$name}++;
			}
		}
	}
	close F; 
}

foreach $song (@ARGV){
	@a = ();
	@st = ();
	open FILE,'<',$song or die;
	while ($line = <FILE>) {
		@arr = $line =~ /[a-zA-Z]+/g;
		foreach $x (@arr){
			if ($x){
				$x = uc $x;
				push @st,$x;
			}		
		}
	}
	close FILE;

	foreach $name (@name_arr){
		$sum_prob = 0;
		$prob = 0;
		foreach $word (@st){

			if ($data{$name}{$word}){
				$prob = log(($data{$name}{$word}+1)/$count{$name});
			}
			else{
				$prob = log(1/$count{$name});
			}
			
			$sum_prob += $prob;
		}
		push @a, "$sum_prob,$name";
		
	}
	@a = sort @a;
	($sum_prob,$name) = split /,/,$a[0];
	printf "$song most resembles the work of $name (log-probability=%.1f)\n",$sum_prob;
}





