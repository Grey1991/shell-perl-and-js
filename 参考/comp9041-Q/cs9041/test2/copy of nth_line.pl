#!/usr/bin/perl -w
$num = shift @ARGV;
$file = shift @ARGV;
open F,'<',$file or die;
@lines = <F>;
if ($num <= ($#lines+1)) {
	if($num){
	print $lines[$num-1];	
	}
	
}
# else{
# 	print "\n";
# }
