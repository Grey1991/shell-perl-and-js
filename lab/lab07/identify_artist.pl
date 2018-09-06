#!/usr/bin/perl -w

%count = ();
%total = ();
foreach $file (glob "lyrics/*.txt") {
  open FILE, "<", $file or die;
  $file =~ s/.*\///;
  $file =~ s/.txt//;
  $file =~ s/_/ /g;
  push @artists, $file;
  while ($line = <FILE>) {
      @words = $line =~ /[a-zA-Z]+/g;
      foreach $word (@words) {
        $count{$file}{lc $word}++ ;
        $total{$file}++;
      }
  }
}


foreach $song (@ARGV) {
  %log_f = ();
  open FILE, "<", $song or die;
  while ($line = <FILE>) {
    @words = $line =~ /[a-zA-Z]+/g;
    foreach $word (@words) {
      foreach $artist (@artists) {
        $count{$artist}{lc $word} = 0 if !exists($count{$artist}{lc $word});
        # print log(($count{$artist}{lc $word} + 1)/$total{$artist});
        $log_f{$artist} += log(($count{$artist}{lc $word} + 1)/$total{$artist});
      }
    }
  }
  @names = sort { $log_f{$a} <=> $log_f{$b}} keys %log_f;
  $name = $names[-1];
  printf "$song most resembles the work of $name (log-probability=%.1f)\n",$log_f{$name};
}
