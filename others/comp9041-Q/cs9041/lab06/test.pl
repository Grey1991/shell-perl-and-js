#!/usr/bin/perl -w
# $url = "http://www.handbook.unsw.edu.au/undergraduate/courses/current/COMP2041.html";
# open F, "wget -q -O- $url|" or die;
# while ($line = <F>) {
#     if ($line =~ /Prerequisite: /) {
#     	print $line;
#     }
    
# }
$x = 
@test=('apple','veers','cat','fdf');
$num_apple = grep /^appldee$/, @test;
print $num_apple;