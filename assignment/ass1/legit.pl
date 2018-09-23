#!/usr/bin/perl -w
sub Init {
    die "legit.pl: error: .legit already exists\n" if -d ".legit";
    mkdir ".legit";
    mkdir ".legit/index";
    mkdir ".legit/commit";
    print "Initialized empty legit repository in .legit\n";
}

sub is_folder_empty {
    my $dirname = shift @_;
    opendir( my $dh, $dirname ) or die "Not a directory";
    return scalar( grep { $_ ne "." && $_ ne ".." } readdir($dh) ) == 0;
}

sub Add {

    # error if not init
    die
"legit.pl: error: no .legit directory containing legit repository exists\n"
      if !-d ".legit";

    # error if add a non-exist file
    foreach $file (@_) {
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

sub Show {

    # error if not init
    die "legit.pl: error: no .legit directory containing legit repository exists\n"
      if !-d ".legit";

    # error if not commit
    die "legit.pl: error: your repository does not have any commits yet\n"
      if is_folder_empty(".legut/commit");

    # error if no or more than one arguments
    die "usage: legit.pl show <commit>:<filename>\n"
      if ( scalar @_ != 1 || $_[0] !~ /^.*:.*$/ );

}

$arg = shift @ARGV;
Init()        if $arg eq "init";
Add(@ARGV)    if $arg eq "add";
Commit(@ARGV) if $arg eq "commit";
Show(@ARGV)   if $arg eq "show";
