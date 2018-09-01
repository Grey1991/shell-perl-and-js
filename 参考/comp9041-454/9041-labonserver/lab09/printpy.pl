#!/usr/bin/perl -w
print "#!/usr/bin/python3\n";
$output=$ARGV[0];
if ($output=~ /\\/){
  $output=~ s/\\/\\\\/g;
}
if ($output=~ /\'/){
  $output=~ s/\'/\\\'/g;
}
if ($output=~ /\n/){
  $output=~ s/\n/\\n/g;
}
print "print('$output')\n";
