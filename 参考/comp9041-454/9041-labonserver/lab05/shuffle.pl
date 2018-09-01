#!/usr/bin/perl -w
@list=();
$leng=0;
while($line=<STDIN>){
   $list[$leng]=$line;
   $leng=$leng+1;
}
$cl=0;
@indnum=();
$numid=0;
$flag=0;
while ($cl != $leng){
  $idd=int(rand($leng));
  foreach $e(@indnum){
    if ($e == $idd) {
       $flag=1;
       last;
    }
  }
  if ($flag == 1){
    $flag=0;
  }
  else {
     $indnum[$numid]=$idd;
     $cl=$cl+1;
     $numid=$numid+1;
     $flag=0;
     printf "$list[$idd]";
  }
}
