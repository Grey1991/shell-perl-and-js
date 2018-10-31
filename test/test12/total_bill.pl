#!/usr/bin/perl -w
$total = 0;
while ($line = <>){
    $total += $1 if $line =~ /"\$(\d+\.\d+)"/;
}
printf "\$%.2f\n",$total;
