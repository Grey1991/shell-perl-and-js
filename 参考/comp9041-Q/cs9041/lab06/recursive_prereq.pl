#!/usr/bin/perl -w
if (@ARGV == 1){
    $target = shift @ARGV or die;
}
else{
    $target = $ARGV[1];
    $flag = 1;
}

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
if ($flag){
    while (1) {
        @pre_arr = @arr3;
        foreach $new_target (@pre_arr){
            $url1 = "http://www.handbook.unsw.edu.au/postgraduate/courses/current/$new_target.html";
            $url2 = "http://www.handbook.unsw.edu.au/undergraduate/courses/current/$new_target.html";
            open F, "wget -q -O- $url1|" or die;
            while ($line = <F>) {
                if($line =~ /Prerequisites?: ([^<]*)/){
                    @arr1= $1 =~ /(\w{4}\d{4})/g;
                    foreach $x (@arr1){
                        if (not grep {$_ eq $x} @arr3){
                            push @arr3,$x;
                        }
                    }
                }  
            }
            close F;
            open F, "wget -q -O- $url2|" or die;
            while ($line = <F>) {
                if($line =~ /Prerequisites?: ([^<]*)/){
                    @arr2= $1 =~ /(\w{4}\d{4})/g;
                    foreach $x (@arr2){
                        if (not grep {$_ eq $x} @arr3){
                            push @arr3,$x;
                        }
                    }
                }  
            }
            close F;
        }
        if ($#pre_arr == $#arr3){
            last;
        }
    }
}
foreach $x (sort(@arr3)){
  print $x,"\n";
}
# print "--------\n"