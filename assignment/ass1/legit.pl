#!/usr/bin/perl -w
use File::Compare;
use File::Basename;
use File::Copy;

sub Init {
  die "legit.pl: error: .legit already exists\n" if -d ".legit";
  mkdir ".legit";
  mkdir ".legit/index";
  mkdir ".legit/commit";
  print "Initialized empty legit repository in .legit\n";
}

sub check_filename {
  my $filename = shift @_;
  die "legit.pl: error: invalid filename '$filename'\n"
    if $filename !~ /^[a-zA-Z0-9]+[a-zA-Z0-9.\-_]*$/;
}

sub is_folder_empty {
  my $dirname = shift @_;
  opendir( my $dh, $dirname ) or die "Not a directory";
  return scalar( grep { $_ ne "." && $_ ne ".." } readdir($dh) ) == 0;
}

sub if_modify {
  $dir1 = $_[0];
  $dir2 = $_[1];
  @files1 = glob("$dir1/*");
  @files2 = glob("$dir2/*");
  return 1 unless scalar(@files1) == scalar(@files2);
  foreach $file (@files1) {
    $filename = basename($file);
    return 1 unless compare("$file","$dir2/$filename") == 0;
  }
  return;
}

sub Add {

  # error if not init
  die "legit.pl: error: no .legit directory containing legit repository exists\n"
    unless -d ".legit";

  # error if add a non-exist file
  foreach $file (@_) {
    check_filename(@_);
    die "legit.pl: error: can not open '$file'\n" unless -f $file;
  }

  # copy files to index
  foreach $file (@_) {
    copy($file,".legit/index/$file");
  }
}

sub Commit {

  # error if not init
  die "legit.pl: error: no .legit directory containing legit repository exists\n"
    unless -d ".legit";

  # nothing follow commit
  die "usage: legit.pl commit [-a] -m commit-message\n"
    unless @_;
  $option = shift @_;

  # commit -m commit-message
  if ( $option eq "-m" ) {
    # error no or more than one message
    die "usage: legit.pl commit [-a] -m commit-message\n" if scalar @_ != 1;
  }
  # commit -a -m commit-message
  elsif ($option eq "-a") {
    $option2 = shift @_;
    # error no -m or no or more message
    die "usage: legit.pl commit [-a] -m commit-message\n"
      if (scalar @_ != 1) || ($option2 ne "-m");
  }
  else {
    die "usage: legit.pl commit [-a] -m commit-message\n";
  }

  # check if message valid
  $message = shift @_;
  die "usage: legit.pl commit [-a] -m commit-message\n"
    if ($message =~ /^ *$/)||($message =~ /^-+/);

  # commit before add
  print "nothing to commit\n" and exit(0)
    if is_folder_empty(".legit/index");

  # add all files in index if -a
  if ($option eq "-a") {
    foreach $file (glob ".legit/index/*") {
      $filename = basename($file);
      copy("$filename",$file);
    }
  }

  # get current commit index number
  $index_number = 0;
  if ( -f ".legit/log.txt" ) {
      open FILE, "<", ".legit/log.txt";
      $index_number++ while (<FILE>);
      close FILE;
  }

  # commit without change
  if ($index_number > 0) {
    $last_index_number = $index_number -1;
    print "nothing to commit\n" and exit(0)
      unless if_modify(".legit/index",".legit/commit/commit_$last_index_number");
  }
  # write log
  open FILE, ">>", ".legit/log.txt";
  print FILE "$index_number $message\n";
  close FILE;

  # make commit_index directory and copy files from index to commit_index
  $dir = ".legit/commit/commit_$index_number";
  mkdir $dir;
  foreach $file ( glob ".legit/index/*" ) {
    $filename = basename($file);
    copy($file,"$dir/$filename");
  }
  print "Committed as commit $index_number\n";
}

sub Log {
  # error if not init
  die "legit.pl: error: no .legit directory containing legit repository exists\n"
    unless -d ".legit";

  # error if more arguments
  die "usage: legit.pl log\n"
    if @_;

  # error if not commit
  die "legit.pl: error: your repository does not have any commits yet\n"
    if is_folder_empty(".legit/commit");

  open FILE, "<", ".legit/log.txt";
  @lines = <FILE>;
  print reverse @lines;
  close FILE;
}


sub Show {

  # error if not init
  die "legit.pl: error: no .legit directory containing legit repository exists\n"
    unless -d ".legit";

  # error if not commit
  die "legit.pl: error: your repository does not have any commits yet\n"
    if is_folder_empty(".legit/commit");

  # error if no or more than one arguments
  die "usage: legit.pl show <commit>:<filename>\n"
    if scalar @_ != 1;

  # error if no ":"
  die "legit.pl: error: invalid object $_[0]\n"
    if $_[0] !~ /^.*:.*$/;

  # get directory and filename
  $show_dir = $_[0];
  $show_dir =~ s/:.*$//;
  $show_file = $_[0];
  $show_file =~ s/^.*://;

  # show files in index
  if ($show_dir eq '') {
    check_filename($show_file);
    die "legit.pl: error: '$show_file' not found in index\n"
      unless -f ".legit/index/$show_file";
    open FILE, "<", ".legit/index/$show_file";
    print $line while ($line = <FILE>);
    close FILE;
  }
  # show files in commit
  else {

    # error no match commit
    die "legit.pl: error: unknown commit '$show_dir'\n"
      unless -d ".legit/commit/commit_$show_dir";

    check_filename($show_file);

    # error no match file in commit
    die "legit.pl: error: '$show_file' not found in commit $show_dir\n"
      unless -f ".legit/commit/commit_$show_dir/$show_file";
    open FILE, "<", ".legit/commit/commit_$show_dir/$show_file";
    print $line while ($line = <FILE>);
    close FILE;
  }
}

$arg = shift @ARGV;
Init()        if $arg eq "init";
Add(@ARGV)    if $arg eq "add";
Commit(@ARGV) if $arg eq "commit";
Log(@ARGV)    if $arg eq "log";
Show(@ARGV)   if $arg eq "show";
if_modify(@ARGV) if $arg eq "diff";
copy("a",".legit/index/a") if $arg eq "copy";
