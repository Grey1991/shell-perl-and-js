#!/usr/bin/perl -w
# @arr = ();
while ($line = <>){
	@tmp = ();
	# @arr = ();
	chomp $line;
	@tmp = split / /,$line;
	# pop @tmp;
	# foreach $x (@tmp){
	# 	if ($x ne "\n"){
	# 		push @arr,$x;
	# 	}
	# }
	# # shift @arr;
	print join" ",sort @tmp;
	print "\n";
}