#!/usr/bin/perl -w
$course=$ARGV[0];
@result=();
$url = "http://www.timetable.unsw.edu.au/current/$course"."KENS.html\n";
open F, "wget -q -O- $url|" or die;
while ($line = <F>) {
  @a=$line=~ /$course\d{4}/g;
  push @result, @a;
}
%count=();
@result=grep { ++$count{ $_ } < 2 } @result;
foreach $i (sort @result){
  printf "$i\n";
}
