#!/usr/bin/perl -w
@tot=();
while($line=<STDIN>){
  chomp($line);
  @eachline=split(/ +/,$line);
  @eachline=sort @eachline;
  foreach $k(@eachline){
      push @tot,$k;
      push @tot," ";
  }
  push @tot,"\n";
}

foreach $i (@tot){
  printf "$i";
}
