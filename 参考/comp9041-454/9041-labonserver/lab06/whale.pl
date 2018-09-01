#!/usr/bin/perl -w
$name=$ARGV[0];
$line=0;
$totnum=0;
while ($data=<STDIN>){
   if ($data=~ /$name/){
     $line=$line+1;
     $currnum=(split / /,$data)[0];
     $totnum=$totnum+$currnum;
   }
}
printf "$name observations: $line pods, $totnum individuals\n";
