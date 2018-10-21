#!/usr/bin/perl -w
@number_list = ();
@result_list = ();
while($line=<STDIN>){
    @line_list = split/\s+/,$line;
    foreach $i (@line_list){
      if ($i=~/\d+/){
        push @number_list,$i;
      }
    }
}
for ($i=0;$i<=$#number_list;$i++){
    $count=0;
    $each = $number_list[$i];
    for ($j=0;$j<=$#number_list;$j++){
        if ($j==$i){
          next;
        }
        if ($each % $number_list[$j]==0){
          $count++;
        }
    }
    if ($count==0){
        push @result_list,$each;
    }
}
@result_list = sort{$a <=> $b} @result_list;
foreach $i (@result_list){
    print "$i ";
}
print "\n";
