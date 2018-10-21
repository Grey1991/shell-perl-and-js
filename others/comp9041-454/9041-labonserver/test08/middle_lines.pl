#!/usr/bin/perl -w
$num_line=0;
@line_list=();
while ($line=<>){
    push @line_list,$line;
    $num_line++;
}
if ($num_line==0){
  print "";
}
elsif ($num_line%2==0){
  $first_line=$line_list[$num_line/2-1];
  $last_line=$line_list[$num_line/2];
  print "$first_line";
  print "$last_line";
}
else {
  $first_line=$line_list[($num_line-1)/2];
  print "$first_line";
}
