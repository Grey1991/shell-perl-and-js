#!/usr/bin/perl -w
@number_list=();
@content_list=();
$flag=0;
while ($line=<>){
  push @content_list,$line;
  @line_list=split(/ +/,$line);
  foreach $i (@line_list){
    if ($i=~ /(\-?\.?\d+(\.\d+)?)/){
      push @number_list,$1;
      if ($flag==0){
        $min_num=$1;
        $flag=1;
      }
    }
  }
}

if (defined $min_num){
  foreach $j(@number_list){
    if ($j>=$min_num){
      $min_num=$j;
    }
  }

  foreach $k(@content_list){
    if ($min_num>0 and $k=~ /\-$min_num/){
      print "";
    }
    elsif ($k=~ /$min_num/){
      print "$k";
    }
  }
}
