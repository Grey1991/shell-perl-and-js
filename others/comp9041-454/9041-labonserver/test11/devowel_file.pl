#!/usr/bin/perl -w
@need_print = ();
$name = $ARGV[0];
while ($line = <>){
    $line =~ s/[aeiou]//ig;
    push @need_print, $line;
}
open F,'>',"$name" or die;
print F @need_print;
close F;
