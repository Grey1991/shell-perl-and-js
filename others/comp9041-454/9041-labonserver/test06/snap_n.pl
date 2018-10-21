#!/usr/bin/perl -w
%occ=();
$w='';
while($line=<STDIN>){
  $occ{$line}++;
}
foreach $i (keys %occ){
  if ($occ{$i}==$ARGV[0]) {
    $w=$i;
    last;
  }
}
if ($w ne '') {
  printf "Snap: $w";
}
