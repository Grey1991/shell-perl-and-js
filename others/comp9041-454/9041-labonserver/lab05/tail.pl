#!/usr/bin/perl -w
@string=();
$leng=0;
if (@ARGV==0){
  while ($line=<STDIN>){
    $string[$leng]=$line;
    $leng=$leng+1;
 }
 if ($leng<=10) {
   for($i=0;$i<$leng;$i++){
     printf "$string[$i]";
   }
 }
 else {
   $firind=$leng-10;
   for($i=$firind;$i<$leng;$i++){
     printf "$string[$i]";
   }
 }
}
else {
  if ($ARGV[0]=~ /^-/){
    $pleng=-$ARGV[0];
    if(@ARGV==2){
       open(DATA, "<$ARGV[1]") || die "tail.pl: can't open $ARGV[1]\n";
       foreach $line(<DATA>) {
         $string[$leng]=$line;
         $leng=$leng+1;
       }
       $firind=$leng-$pleng;
       if ($firind<0){
         $firind=0;
       }
       for($i=$firind;$i<$leng;$i++){
         printf "$string[$i]";
       }
       close(DATA);
    }
    else {
      for($i=1;$i<=$#ARGV;$i++){
        @string=();
        $leng=0;
        open(DATA, "<$ARGV[$i]") || die "tail.pl: can't open $ARGV[$i]\n";
        foreach $line(<DATA>) {
          $string[$leng]=$line;
          $leng=$leng+1;
        }
        $firind=$leng-$pleng;
        if ($firind<0){
          $firind=0;
        }
        printf "==> $ARGV[$i] <==\n";
        for($j=$firind;$j<$leng;$j++){
          printf "$string[$j]";
        }
        close(DATA);
      }
    }
  }
  else {
    if(@ARGV==1){
      open(DATA, "<$ARGV[0]") || die "tail.pl: can't open $ARGV[0]\n";
      foreach $line(<DATA>) {
        $string[$leng]=$line;
        $leng=$leng+1;
      }
      $firind=$leng-10;
      if ($firind<0){
        $firind=0;
      }
      for($i=$firind;$i<$leng;$i++){
        printf "$string[$i]";
      }
    }
    else {
      for($i=0;$i<=$#ARGV;$i++){
        @string=();
        $leng=0;
        open(DATA, "<$ARGV[$i]") || die "tail.pl: can't open $ARGV[$i]\n";
        foreach $line(<DATA>) {
          $string[$leng]=$line;
          $leng=$leng+1;
        }
        $firind=$leng-10;
        if ($firind<0){
          $firind=0;
        }
        printf "==> $ARGV[$i] <==\n";
        for($j=$firind;$j<$leng;$j++){
          printf "$string[$j]";
        }
        close(DATA);
      }
    }
  }
}
