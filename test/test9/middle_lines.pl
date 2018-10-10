#!/usr/bin/perl -w

$file = $ARGV[0];
open F ,'<', $file;
@lines = <F>;
$num_of_lines = $#lines +1;
if (@lines){
  if ($num_of_lines % 2 == 0) {
    print $lines[$num_of_lines/2 -1];
    print $lines[$num_of_lines/2];
  }
  else{
    print $lines[($num_of_lines-1)/2];
  }
}
