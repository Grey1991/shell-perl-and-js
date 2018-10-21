#!/usr/bin/perl -w
@list = ();
foreach $ele (@ARGV){
    push @list, $ele;
}
@list = sort{$a <=> $b} @list;
$list_len = @list;
$index = ($list_len-1)/2;
print "$list[$index]\n";
