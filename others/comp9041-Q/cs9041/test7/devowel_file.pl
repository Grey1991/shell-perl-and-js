#!/usr/bin/perl -w
$file = shift @ARGV;
open F,'<',$file or die;
@lines = <F>;
close F;

open F,'>',$file or die;
foreach $line (@lines){
  $line =~ s/[aeiou]//gi;
  print F $line;
}
close F;



















# $file = shift @ARGV;
# open F, '<',$file;
# while ($line = <F>) {
#   push @arr, $line;
# }
# close F;
# # print join "|",@arr;
# # print "\n";
# open F , '>',$file;
# print F '';
# close F;
# open F , '>>',$file;
# foreach $line (@arr){
#   $line =~ s/[aeiou]//gi;
#   print F $line;
# }
