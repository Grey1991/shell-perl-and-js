#!/usr/bin/perl -w
%content = ();
while ($line = <STDIN>){
  if (!$content{$line}){
    $content{$line} = 1;
  }
  elsif ($content{$line}<$ARGV[0]){
    $content{$line}++;
    if ($content{$line} == $ARGV[0]){
      print "Snap: $line";
      exit;
    }
  }
}
