#!/usr/bin/perl -w


while ($line = <>) {
  push @record,$line;
  @arr = ();
  @num = $line =~ /-?\d*\.?\d*/g;
  foreach $x (@num){
    if (($x ne "") and ($x ne '.') and ($x ne '-') and ($x ne '-.')){
      push @arr,$x;
    }
  }
  # print join "|",@num;
  if (@arr){
    @sorted = sort {$b <=> $a}(@arr);
    $hash{$line} = $sorted[0];
  }
  else{
    $hash{$line} = -100000000000000000000000;
  }
}
# print %hash;


@sorted_key = sort { $hash{$b} <=> $hash{$a} } keys %hash;

$largest = $hash{$sorted_key[0]};
# print join "::",@sorted_key;
if ($largest >  -1000000000000000000){
  foreach my $x (@record){
    if ($hash{$x} == $largest){
      print $x;
    }
  }

}
