#!/usr/bin/perl -w
$course=$ARGV[0];
$len=0;
@cl=();
$url = "http://www.handbook.unsw.edu.au/postgraduate/courses/2017/$course.html";
open F, "wget -q -O- $url|" or die;
while ($line = <F>) {
  if ($line=~ /<p>Prerequisite:|<p>Prerequisites:/){
    $line=~ s/<\/p><p><strong>.*//;
    $line=~ s/.*<p>//;
    $line=~ s/Prerequisite: //;
    $line=~ s/Prerequisites: //;
    while ($line=~ /[A-Z]{4}\d{4}/){
      $cl[$len]=$&;
      $line=~ s/[A-Z]{4}\d{4}//;
      $len++;
    }
  }
}
$url = "http://www.handbook.unsw.edu.au/undergraduate/courses/2017/$course.html";
open F, "wget -q -O- $url|" or die;
while ($line = <F>) {
  if ($line=~ /<p>Prerequisite:|<p>Prerequisites:/){
    $line=~ s/<\/p><p><strong>.*//;
    $line=~ s/.*<p>//;
    $line=~ s/Prerequisite: //;
    $line=~ s/Prerequisites: //;
    while ($line=~ /[A-Z]{4}\d{4}/){
      $cl[$len]=$&;
      $line=~ s/[A-Z]{4}\d{4}//;
      $len++;
    }
  }
}
%count=();
@cl=grep { ++$count{ $_ } < 2 } @cl;
foreach $data(sort @cl){
  printf "$data\n";
}
