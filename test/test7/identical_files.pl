#!/usr/bin/perl -w
$target = shift @ARGV;
@arr = ();
open F,"<",$target or die "Usage: ./identical_files.pl <files>\n";
while ($line = <F>) {
  push @arr, $line;
}
for $file (@ARGV) {
  open FILE,"<",$file or die "Usage: ./identical_files.pl <files>\n";
  $i = 0;
  while ($line = <FILE>) {
    if ($i > $#arr) {
      print "$file is not identical\n";
      exit;
    }
    if ($line eq $arr[$i]) {
      $i++;
    }
    else {
      print "$file is not identical\n";
      exit;
    }
  }
  if ($i < $#arr) {
    print "$file is not identical\n";
    exit;
  }
}
print "All files are identical\n";
