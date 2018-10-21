#!/usr/bin/perl -w
$ori_word = shift @ARGV;
# print $ori_word;
$word = uc $ori_word;
# print $word,"\n";
foreach $file (glob "lyrics/*.txt") {
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
		# $tmp = 0;
		foreach $x (@arr){
			if ($x){
				$count_all++;
			}

			chomp $x;
			$up = uc $x;
			# print $x,",",$up,"|";
			if ($up eq $word){
				$count++;
			}
		}
	}
	$new_count = $count+1;
	# $count = sprintf "%4d",$count;
	# $count_all = sprintf "%6d",$count_all;
	# $ans = sprintf "%.9f",$count/$count_all;
	# print "$count/$count_all = $ans $name","\n";
	printf "log((%d+1)/%6d) = %8.4f %s\n",$count,$count_all,log($new_count/$count_all),$name;
	close F;
}