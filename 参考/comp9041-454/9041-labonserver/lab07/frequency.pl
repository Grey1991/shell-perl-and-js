#!/usr/bin/perl -w
$word=$ARGV[0];
%cw=();
%ct=();
foreach $file (glob "lyrics/*.txt") {
  $len=0;
  $len2=0;
  open F,'<',"$file" or die;
  while ($line=<F>){
    @a=$line=~ /\b$word\b/ig;
    $len+=@a;
    @b=$line=~ /[a-zA-Z]+/g;
    $len2+=@b;
  }
  $file=~ s/.*\///;
  $file=~ s/.txt//;
  $file=~ s/[^a-z]/ /gi;
  $cw{$file}=$len;
  $ct{$file}=$len2;
}


for $i (sort keys %cw){
    printf "%4d/%6d = %.9f %s\n",$cw{$i},$ct{$i},$cw{$i}/$ct{$i},$i;
}
