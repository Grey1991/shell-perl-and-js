#!/usr/bin/perl -w
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

sub Add {

    # error if not init
    die "legit.pl: error: no .legit directory containing legit repository exists\n"
      if !-d ".legit";

    # error if add a non-exist file
    foreach $file (@_) {
      check_filename(@_);
      die "legit.pl: error: can not open '$file'\n" if !-f $file;
    }



    # copy files to index
    foreach $file (@_) {
        open DATA1, "<", $file or die;
        open DATA2, ">", ".legit/index/$file";
        while ( $line = <DATA1> ) {
            print DATA2 $line;
        }
        close DATA1;
        close DATA2;
    }
}

sub Commit {

    # error if not init
    die
"legit.pl: error: no .legit directory containing legit repository exists\n"
      if !-d ".legit";

    # nothing follow commit
    die "usage: legit.pl commit [-a] -m commit-message\n" if !@_;
    $option = shift @_;
    if ( $option eq "-m" ) {

        # error no or more than one message
        die "usage: legit.pl commit [-a] -m commit-message\n" if scalar @_ != 1;

        # commit brefor add
        die "nothing to commit\n" if is_folder_empty(".legit/index");

        $message      = shift @_;
        $index_number = 0;
        if ( -f ".legit/log.txt" ) {
            open FILE, "<", ".legit/log.txt";
            $index_number++ while (<FILE>);
            close FILE;
            open FILE, ">>", ".legit/log.txt";
            print FILE "$index_number $message\n";
            close FILE;
        }
        else {
            open FILE, ">", ".legit/log.txt";
            print FILE "$index_number $message\n";
            close FILE;
        }

        mkdir ".legit/commit" if !-d "/.legit/commit";
        $dir = ".legit/commit/commit_$index_number";
        mkdir $dir;
        foreach $file ( glob ".legit/index/*" ) {
            $file =~ s/^.legit\/index\///;
            open DATA1, "<", $file        or die;
            open DATA2, ">", "$dir/$file" or die;
            while ( $line = <DATA1> ) {
                print DATA2 $line;
            }
            close DATA1;
            close DATA2;
        }
        print "Committed as commit $index_number\n";
    }
}

sub Log {
  # error if not init
  die "legit.pl: error: no .legit directory containing legit repository exists\n"
    if !-d ".legit";

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
      if !-d ".legit";

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
        if !-f ".legit/index/$show_file";
      open FILE, "<", ".legit/index/$show_file";
      print $line while ($line = <FILE>);
      close FILE;
    }
    # show files in commit
    else {

      # error no match commit
      die "legit.pl: error: unknown commit '$show_dir'\n"
        if !-d ".legit/commit/commit_$show_dir";

      check_filename($show_file);

      # error no match file in commit
      die "legit.pl: error: '$show_file' not found in commit $show_dir\n"
        if !-f ".legit/commit/commit_$show_dir/$show_file";
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
