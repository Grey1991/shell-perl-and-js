#!/usr/bin/perl -w
# sub recursion {
#     my ($i, @list) = @_;
#     my $total = 0;
#     foreach $element (@list) {
#        $total += $element;
#     }
#     return $total;
# }




$file = shift @ARGV;
open F, '<', $file;
@script = <F>;
# print @script;

$i = 0;
# print "$script[2]","\n";
while ($i <= $#script) {
  $line = $script[$i];
  chomp $line;
  # print "$line|$i\n";
  if ($line =~ /^#!/){
    push @perl,"#!/usr/bin/perl -w\n";
    $i++;
    next;
  }
  if ($line =~ /^#/ or $line =~ /^\s$/){
    push @perl,"$line\n";
    $i++;
    next;
  }
  if ($line =~ /^(\s*)(\w+)=(\$?\d+|\$?\w+)/) {
    chomp $line;
    $new = "$1\$$2 = $3;\n";
    # push @variables, $2;
    push @perl, $new;
    $i++;
    next;
  }
  if ($line =~ /^(\s*)echo (.*)$/) {
    $new = "${1}print \"$2\\n\"\n";
    push @perl, $new;
    $i++;
    next;
  }
  # if ($line =~ /^\s*while \((.+)\s(.+)\s(.+)\)/) {
  #   # body...
  # }
  if ($line =~ /^(\s*)(\w+)=\$\((.*)\)/){
    $in = $3;
    $space = $1;
    $word = $2;
    @x = $in =~ /([a-zA-Z]+)/g;
    my %count;
    my @uniq_x = grep { ++$count{ $_ } < 2; } @x;
    foreach $tmp (@uniq_x){
      $in =~ s/$tmp /\$$tmp /g;
      $in =~ s/$tmp\)/\$$tmp\)/g;
    }
    $in =~ /\((.*)\)/;
    $new = "$space\$$word = $1;\n";
    push @perl, $new;
    $i++;
    next;
  }
  if ($line =~ /^(\s*)(while|if) \((.*)\)/){
    $in = $3;
    $space = $1;
    $word = $2;
    @x = $in =~ /([a-zA-Z]+)/g;
    my %count;
    my @uniq_x = grep { ++$count{ $_ } < 2; } @x;
    foreach $tmp (@uniq_x){
      $in =~ s/$tmp /\$$tmp /g;
      $in =~ s/$tmp\)/\$$tmp\)/g;
    }
    # $in =~ /\((.*)\)/;
    $new = "$space$word $in \{\n";
    push @perl, $new;
    $i++;
    next;
  }
  if ($line =~ /^(\s*)(fi|done)/){
    $line =~ s/(fi|done)/}/;
    # $in =~ /\((.*)\)/;
    $new = "$line\n";
    push @perl, $new;
    $i++;
    next;
  }
  if ($line =~ /^(\s*)(do|then)/){
    # $line =~ s/else/} else {/;
    $i++;
    next;
  }
  if ($line =~ /^(\s*)(else)/){
    $line =~ s/else/} else {/;
    # $in =~ /\((.*)\)/;
    $new = "$line\n";
    push @perl, $new;
    $i++;
    next;
  }
  else{
    push @perl, "$line\n";
    $i++;
  }
}
print @perl;
