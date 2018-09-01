#!/usr/bin/perl -w
while ($data=<STDIN>){
   $data=~ tr/A-Z/a-z/;
   $data=~ s/ +/ /g;
   $data=~ s/^ //;
   $data=~ s/ $//;
   $data=~ s/s$//;
   $data=~ s/ /=/;
   $wa=(split /=/,$data)[1];
   chomp $wa;
   $wn=(split /=/,$data)[0];
   $wi{$wa}+=$wn;
   $wl{$wa}++;
}
foreach $wa(sort keys %wi){
   printf "$wa observations: $wl{$wa} pods, $wi{$wa} individuals\n";
}
