#!/usr/bin/perl -w
if (@ARGV > 0 && $ARGV[0] =~ /-\d+/) {
    $max = shift @ARGV;
    $max =~ s/-//;
} else {
    $max = 10;
}

if (@ARGV == 0) {
  @lines = <>;
  $start = $#lines + 1 - $max;
  if ($start >= 0) {
    print @lines [$start..$#lines]
  }
  else{
    print @lines;
  }
}

if (@ARGV == 1) {
  $file = $ARGV[0];
  open FILE, '<', $file or die "$0: Can't open $file: $!\n";
  @lines = <FILE>;
  $start = $#lines + 1 - $max;
  if ($start >= 0) {
    print @lines [$start..$#lines]
  }
  else{
    print @lines;
  }
  close FILE;
}
else {
  foreach $file (@ARGV) {
    open FILE, '<', $file or die "$0: can't open $file\n";
		@lines = <FILE>;
		print "==> $file <==\n";
		$start = $#lines + 1 - $max;
		if ($start >= 0) {
			print @lines [$start..$#lines];
		}
		else{
			print @lines;
		}
		close FILE;
  }
}
