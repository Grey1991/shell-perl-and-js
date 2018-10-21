#!/usr/bin/perl -w
$totline=0;
$at=0;
@alist=();
$flag=0;
while ($line=<STDIN>){
  $totline++;
  $line=~ s/^ *//;
  $line=~ s/ *$//;
  $line=~ tr/[A-Z]/[a-z]/;
  $line=~ s/ +/ /;
  foreach $i(@alist){
    if ($i eq $line){
      $flag=1;
      last;
    }
  }
  if ($flag==1){
    $flag=0;
  }
  else{
    push @alist,$line;
    $at++;
  }
  if ($at==$ARGV[0]){
    last;
  }
}
if ($at==$ARGV[0]){
  printf "$ARGV[0] distinct lines seen after $totline lines read.\n";
}
else{
  printf "End of input reached after $totline lines read - $ARGV[0] different lines not seen.\n";
}
