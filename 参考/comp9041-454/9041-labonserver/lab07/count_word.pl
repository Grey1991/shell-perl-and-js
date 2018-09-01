#!/usr/bin/perl -w
$word=$ARGV[0];
$len=0;
while ($line=<STDIN>){
    @a=$line=~ /\b$word\b/ig;
    $len+=@a;
}
printf "$word occurred $len times\n";
