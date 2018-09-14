#!/usr/bin/perl -w
sub Save {
  $i = 0;
  $dir = ".snapshot.$i";
  while (-d "$dir") {
    $i++;
    $dir = ".snapshot.$i";
  }
  mkdir $dir;
  foreach $file (glob "*") {
    next if $file =~ /^\./ or $file eq "snapshot.pl";
    open DATA1, "<", $file or die;
    open DATA2, ">", "$dir/$file";
    while($line = <DATA1>){
      print DATA2 $line;
    }
    close DATA1;
    close DATA2;
  }
  print "Creating snapshot $i\n";
}

$cmd = $ARGV[0];
if ($cmd eq "save"){
  Save();
}
elsif ($cmd eq "load") {
  $index = $ARGV[1];
  Save();
  foreach $file (glob ".snapshot.$index/*") {
    # print $file,"\n";
    open DATA1, "<", $file or die;
    $file =~ s/\.snapshot\.[0-9]+\///g;
    # print $file,"\n";
    open DATA2, ">", $file or die "Cannot open file ../$file for writing: $!\n";
    while($line = <DATA1>){
      # print $line,"\n";
      print DATA2 $line;
    }
    close DATA1;
    close DATA2;
  }
  print "Restoring snapshot $index\n";
}
