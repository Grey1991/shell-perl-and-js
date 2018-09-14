#!/usr/bin/perl -w
$file = $ARGV[0];
$i = 0;
$backup = ".$file.$i";
while (-e "$backup") {
  $i++;
  $backup = ".$file.$i";
}

open DATA1, "<", $file or die;
open DATA2, ">", $backup;

while($line = <DATA1>){
  print DATA2 $line;
}
close DATA1;
close DATA2;
print "Backup of '$file' saved as '$backup'\n";
