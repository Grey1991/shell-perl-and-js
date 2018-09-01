#!/usr/bin/perl -w
@check=();
$flag=0;
foreach $i(@ARGV){
  foreach $k(@check){
    if ($k eq $i){
      $flag=1;
      last;
    }
  }
if ($flag==0){
push @check,$i;
}
else{
  $flag=0;
}
}
foreach $j(@check){
  printf "$j ";
}
printf "\n";
