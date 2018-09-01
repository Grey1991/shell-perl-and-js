#!/usr/bin/perl -w
# $x = "asdf ,sdfasdf:sdf";
# @a = split /fa/,$x;
# print join "|",@a;
$line = 'while ((i <= finish))';
$line =~ /^(\s*)(while|if) \((.*)\)/;
$in = $3;
$space = $1;
$word = $2;
@x = $in =~ /([a-zA-Z]+)/g;
my %count;
my @uniq_x = grep { ++$count{ $_ } < 2; } @x;
print join "|",@uniq_x;
print "\n";
foreach $tmp (@uniq_x){
  print $tmp,"\n";
  $in =~ s/$tmp /+$tmp /g;
  $in =~ s/$tmp\)/+$tmp\)/g;
  print $in,"\n";
}

# $in =~ /\((.*)\)/;
$new = "$space$word $in\{\n";
print "$new";
