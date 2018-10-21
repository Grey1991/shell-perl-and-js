#!/usr/bin/perl -w
# if ($ARGV[0] eq "-d") {
# 	$file = $ARGV[2]
# }

$i = 0;
while ($i<10){
	$data{"123"}{$i}++;
	$i++;
}
print $data{"123"}{2};



foreach $song (@ARGV){
	@st = ();
	open FILE,'<',$song or die;
	while ($line = <FILE>) {
		@arr = $line =~ /[a-zA-Z]+/g;
		foreach $x (@arr){
			if ($x){
				push @st,$x;
			}		
		}
	}
	# $str = join",",@st;
	# $data{$file} = $str;
	close FILE;
	@a = ();
	foreach $file (glob "lyrics/*.txt") {
		$sum_prob = 0;
		foreach $ori_word (@st){
			$word = uc $ori_word;
			$count_all = 0;
			$count = 0;
			$name = $file;
			$name =~ s/^[^\/]*\///;
			$name =~ s/\.txt$//;
			$name =~ tr/_/ /;
			# print $name,"\n";
			open F ,'<',$file or die;
			while ($line = <F>){
				@arr = $line =~ /[a-zA-Z]+/g;
				foreach $x (@arr){
					if ($x){
						$count_all++;
					}
					chomp $x;
					$up = uc $x;
					if ($up eq $word){
						$count++;
					}
				}
			}
			$new_count = $count+1;
			$prob = log($new_count/$count_all);
			# print "$name:$ori_word:$prob";
			$sum_prob += $prob;
			# printf "log((%d+1)/%6d) = %8.4f %s\n",$count,$count_all,log($new_count/$count_all),$name;
			close F;
		}
		push @a, "$sum_prob,$name";
	}
	@a = sort @a;
	($sum_prob,$name) = split /,/,$a[0];
	printf "$song most resembles the work of $name (log-probability=%.1f)\n",$sum_prob;
}



