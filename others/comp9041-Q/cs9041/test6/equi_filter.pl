#!/usr/bin/perl -w
sub check{
  %data=();
  my @word = @_;
  foreach my $c (@word){
    $test = $c;
    $data{$c}++;
  }
  foreach my $value (values %data){
    if($value != $data{$test}){
      return 0;
    }
  }
  return 1;
}


while($line=<>){
    chomp $line;
    @words = split / +/,$line;
    @answer = ();
    foreach $word (@words){
      if($word){
        %data = ();
        $ori = $word;
        $word =~ tr /[A-Z]/[a-z]/;
        @word = split //,$word;
        if (check(@word)){
          push @answer,$ori;
        }
      }
    }
    print join(" ",@answer),"\n";
}



















# while ($line = <>){
#   @arr = split " ",$line;
#   @answer = ();
#   foreach $x (@arr){
#     $flag = 0;
#     %data = ();
#     $last = $x;
#     @word = ();
#     # $x =~ s/[^a-zA-Z]//g;
#     $x =~ tr/[a-z]/[A-Z]/;
#     @word = split "",$x;
#     # print join"|",@word;
#     foreach $char (@word){
#       $data{$char}++;
#     }
#     # print %data;
#     @count = values %data;
#     $end = $#count;
#     foreach $i (1..$end){
#         if ($count[$i] != $count[$i - 1]){
#           $flag = 1;
#         }
#     }
#     # print $flag;
#     unless ($flag) {
#       push @answer,$last;
#     }
#   }
#   print join " ",@answer;
#   @arr= ();
#   print "\n";
#
# }
