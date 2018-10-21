#!/usr/bin/perl -w
$totline='';
while($line=<STDIN>){
  if ($line=~/\d+/){
    $line=~ s/\d+//g;
  }
  $totline="$totline$line";
}
printf $totline;
