#!/usr/bin/perl -w

die if @ARGV != 2;
$target_species = $ARGV[0];
$filename = $ARGV[1];
open FILE, "<", $filename or die "Can not open $filename\n";
my $current_count = 0;
my $line_num = 0;

while ($line = <FILE>) {
    if ($line =~ /^(\S+)\s+(\d+)\s+(.+)\s*$/) {
        my $count = $2;
        my $species = $3;

        if ($species eq $target_species) {
            $current_count += $count;
            $line_num += 1;
        }
    } else {
        print "Sorry couldn't parse: $line\n";
    }
}
print "$target_species observations: $line_num pods, $current_count individuals\n";
close $filename
