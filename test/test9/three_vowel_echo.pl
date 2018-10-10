#!/usr/bin/perl -w
foreach $arg(@ARGV) {
  $a = $arg =~ tr/[A-Z]/[a-z]/;
  $c = $a =~ tr/[a,e,i,o,u]/0/;
  push @result,$arg if $c =~ /000/;
  print $c;
}
foreach $word(@result){
  print $word;
}
