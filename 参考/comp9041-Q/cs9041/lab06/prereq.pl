#!/usr/bin/perl -w
$target = shift @ARGV or die;

$url1 = "http://www.handbook.unsw.edu.au/postgraduate/courses/current/$target.html";
$url2 = "http://www.handbook.unsw.edu.au/undergraduate/courses/current/$target.html";
open F, "wget -q -O- $url1|" or die;
while ($line = <F>) {
    if($line =~ /Prerequisites?: ([^<]*)/){
    	@arr1= $1 =~ /(\w{4}\d{4})/g;
    }  
}
close F;
open F, "wget -q -O- $url2|" or die;
while ($line = <F>) {
    if($line =~ /Prerequisites?: ([^<]*)/){
    	@arr2= $1 =~ /(\w{4}\d{4})/g;
    }  
}
close F;
@arr3 = sort(@arr1,@arr2);
foreach $x (@arr3){
	print $x,"\n";
}

