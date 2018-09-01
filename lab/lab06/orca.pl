#!/usr/bin/perl -w

for $filename (@ARGV) {
    open my $f, $filename or die "Can not open $filename\n";
    my $current_count = 0;

    while ($line = <$f>) {
        if ($line =~ /^(\S+)\s+(\d+)\s+(.+)\s*$/) {
            my $count = $2;
            my $species = $3;

            if ($species eq "Orca") {
                $current_count += $count;
            }
        } else {
            print "Sorry couldn't parse: $line\n";
        }
    }
    print "$current_count Orcas reported in whales.txt\n";
}
