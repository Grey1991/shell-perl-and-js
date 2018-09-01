#!/usr/bin/perl -w

for $filename (@ARGV) {
    open FILE, "<", $filename or die "Can not open $filename\n";

    while ($line = <FILE>) {
      $line = lc $line;
      $line =~ s/s?$//i;
      $line =~ s/ +/ /g;
      $line =~ s/ $//g;

      if ($line =~ /^(\S+)\s*(\d+)\s+(.+)\s*$/) {
          $count = $2;
          $species = $3;
          $pod{$species} ++;
          $num{$species} += $count;
      } else {
          print "Sorry couldn't parse: $line\n";
      }
    }
    foreach $species (sort keys %pod) {
      print "$species observations: $pod{$species} pods, $num{$species} individuals\n";
    }
}
