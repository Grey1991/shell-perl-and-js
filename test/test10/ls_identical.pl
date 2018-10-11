#!/usr/bin/perl -w
use File::Compare;
use File::Basename;

@result=();
$dir1 = shift @ARGV;
$dir2 = shift @ARGV;
foreach $file (glob "$dir1/*"){
    $filename = basename($file);
    if (-f "$dir2/$filename") {
        push @result,$filename if compare("$file","$dir2/$filename") == 0;
    }
}
@sorted = sort @result;
foreach $e(@sorted){
    print "$e\n"
}