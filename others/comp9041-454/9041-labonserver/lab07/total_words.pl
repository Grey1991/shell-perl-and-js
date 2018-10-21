#!/usr/bin/perl -w
$len=0;
while ($line=<STDIN>){
  @a=$line=~ /[a-zA-Z]+/g;
  $len+=@a;
}
printf "$len words\n";
