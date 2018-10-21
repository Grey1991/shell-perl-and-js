#!/usr/bin/perl -w

# Starting point for COMP[29]041 assignment 1
# http://www.cse.unsw.edu.au/~cs2041/assignments/pypl
# written by Q

sub std_format{                                ## for std format
  my ($in) = @_;
  $in =~ s/(\+|\-|\*|\/|>=|<=|==|=|>|<)(\d|\w)/$1 $2/g;
  $in =~ s/(\d|\w)(\+|\-|\*|\/|>=|<=|==|=|>|<)/$1 $2/g;
  $in =~ s/\/\//\//g;
  return $in;
}


sub push_distinct{                              ## push distinct element  (@out = push_distinct (@arr,$element))
  my (@arr) = @_;
  $element = pop @arr;
  foreach my $x (@arr){
    return @arr if $x eq $element;
  }
  return (@arr, $element);
}

sub keep_going{
  my (@lines) = @_;
  my $line = $lines[0];
  chomp $line;
  $line = std_format($line);
  if ($line =~ /^#!/ ) {  ##print multiple variable
    my $new = "#!/usr/bin/perl -w\n";
    return ($new,keep_going(@lines[1..$#lines])) if (@lines[1..$#lines]);
    return $new;
  }

  ## comment or nothing
  if ($line =~ /^\s*(#|$)/){
    my $new = "$line\n";
    return ($new,keep_going(@lines[1..$#lines])) if (@lines[1..$#lines]);
    return $new;
  }

  ## import
  if ($line =~ /^\s*import/ ) {
    return (keep_going(@lines[1..$#lines])) if (@lines[1..$#lines]);
    return "";
  }

  ##print string
  if ($line =~ /^(\s*)print\s*\("(.*)"\)\s*$/){
    my $new = "${1}print \"$2\\n\";\n";
    return ($new,keep_going(@lines[1..$#lines])) if (@lines[1..$#lines]);
    return $new;
  }

  ##print nothing
  if ($line =~ /^(\s*)print\s*\(\)/){
    my $new = "${1}print \"\\n\";\n";
    return ($new,keep_going(@lines[1..$#lines])) if (@lines[1..$#lines]);
    return $new;
  }

  ##print  variable calculating or single variable
  if ($line =~ /^(\s*)print\s*\(([a-zA-Z_][a-zA-Z0-9_]*.*)\)\s*$/){
    my $indent = $1;
    $line =~ s/([a-zA-Z_][a-zA-Z0-9_]*)/\$$1/g;
    $line =~ s/^(\s*)\$/$1/;
    if ($line =~ /,\s*\$end\s*=['"](.+)['"]/){
      $end = $1;
      $line =~ s/,\s*\$end\s*=.*\)/)/;
    } elsif ($line =~ /,\s*\$end\s*=['"]['"]/){
      $line =~ s/,\s*\$end\s*=.*\)/)/;
      $end = "";
    } else {
      $end = "\\n";
    }
    my $new = "";
    $line =~ /^(\s*)print\s*\((.*)\)/;
    if ($end){
      $new = "${1}print ${2}, \"$end\";\n";
    } else{
      $new = "${1}print ${2};\n";
    }
    return ($new,keep_going(@lines[1..$#lines])) if (@lines[1..$#lines]);
    return $new;
  }

  ##print variable with string
  if ($line =~ /^(\s*)print\s*\(\"(.*)\"\s*%\s*(.*)\)/) {
    my $indent = $1;
    my $string = $2;
    my $varis = $3;
    my $end = "\\n";
    if ($varis =~ /^(.*),\s*end\s*=['"](.*)['"]/){
      $varis = $1;
      $end = $2;
    }
    $varis =~ s/\(//g;
    $varis =~ s/\)//g;
    my @varis = split ",",$varis;
    foreach my $variable (@varis){
      $variable =~ s/^\s*//;
      $variable =~ s/\s*$//;
      $string =~ s/%[0-9.a-zA-Z]+/\${$variable}/;
    }
    $line = "${indent}print \"$string$end\"";
    my $new = "$line;\n";
    return ($new,keep_going(@lines[1..$#lines])) if (@lines[1..$#lines]);
    return $new;
  }


  ## declare variable
  if ($line =~ /^(\s*)([a-zA-Z_][a-zA-Z0-9_]*)\s*=\s*[^\[\]a-zA-Z]+$/) {
    my $indent = $1;
    @variables = push_distinct(@variables, $2);
    $line =~ s/([a-zA-Z_][a-zA-Z0-9_]*)/\$$1/g;
    my $new = "$line;\n";
    return ($new,keep_going(@lines[1..$#lines])) if (@lines[1..$#lines]);
    return $new;
  }

  ## operation on variables
  if ($line =~ /^(\s*)([a-zA-Z_][a-zA-Z0-9_]*)\s*=\s*([^\[\]]+)$/) {
    @variables = push_distinct(@variables, $2);
    $right = $3;
    if ($right =~ /(int\()?sys\.stdin\.readline\(\)\)?/) {
      $line =~ s/(int\()?sys\.stdin\.readline\(\)\)?/<STDIN>/;
      $line =~ s/^(\s*)([a-zA-Z_][a-zA-Z0-9_]*)/$1\$$2/g;
    } elsif ($right =~ /sys\.stdin\.readlines\(\)/){
      $line =~ s/sys\.stdin\.readlines\(\)/<STDIN>/;
      $line =~ s/^(\s*)([a-zA-Z_][a-zA-Z0-9_]*)/$1\@$2/g;
    } else {
      $line =~ s/([a-zA-Z_][a-zA-Z0-9_]*)/\$$1/g;
    }
    $line =~ s/\$([a-zA-Z_][a-zA-Z0-9_]*)\.\$pop\(\)/pop \@$1/g;  ## translate pop
    $line =~ s/\$len\(\$([a-zA-Z_][a-zA-Z0-9_]*)\)/(\$#$1 + 1)/;  ## translate len
    my $new = "$line;\n";

    return ($new,keep_going(@lines[1..$#lines])) if (@lines[1..$#lines]);
    return $new;
  }

  ## one-line while
  if ($line =~ /(^\s*)while (.*): (.+)$/){
    my $indent = $1;
    my $condition = $2;
    my @statements = split /; /, $3;
    foreach my $statement (@statements){
      $statement =~ s/^/\t$indent/;
    }
    $condition =~ s/([a-zA-Z_][a-zA-Z0-9_]*)/\$$1/g;
    my $new = "${indent}while ($condition) {\n";
    return ($new,keep_going(@statements),"$indent}\n",keep_going(@lines[1..$#lines])) if (@lines[1..$#lines]);
    return ($new,keep_going(@statements),"$indent}\n");
  }

  ## multi-line while
  if ($line =~ /^(\s*)while (.*):\s*$/) {
    my $indent = $1;
    my $condition = $2;
    my $fi = $#lines + 1;
    foreach my $x (1..$#lines){
      if ($lines[$x] !~ /^$indent(\t|    )/){
        $fi = $x;
        last;
      }
    }
    $condition =~ s/([a-zA-Z_][a-zA-Z0-9_]*)/\$$1/g;
    my $new = "${indent}while ($condition) {\n";
    return ($new,keep_going(@lines[1..$fi-1]),"$indent}\n",keep_going(@lines[$fi..$#lines])) if (@lines[$fi..$#lines]);
    return ($new,keep_going(@lines[1..$fi-1]),"$indent}\n");
  }

  ## one-line if
  if ($line =~ /(^\s*)if (.*): (.+)$/){
    my $indent = $1;
    my $condition = $2;
    my @statements = split /; /, $3;
    foreach my $statement (@statements){
      $statement =~ s/^/\t$indent/;
    }
    $condition =~ s/([a-zA-Z_][a-zA-Z0-9_]*)/\$$1/g;
    my $new = "${indent}if ($condition) {\n";
    return ($new,keep_going(@statements),"$indent}\n",keep_going(@lines[1..$#lines])) if (@lines[1..$#lines]);
    return ($new,keep_going(@statements),"$indent}\n");
  }

  ## multi-line if
  if ($line =~ /(^\s*)if (.*):\s*$/){
    my $indent = $1;
    my $condition = $2;
    $condition =~ s/([a-zA-Z_][a-zA-Z0-9_]*)/\$$1/g;
    my $new = "${indent}if ($condition) {\n";
    my $fi = $#lines + 1;
    foreach my $x (1..$#lines){
      if ($lines[$x] !~ /^$indent(\t|    )/){
        $fi = $x;
        last;
      }
    }
    if ($lines[$fi] and $lines[$fi] =~ /^${indent}el(if|se)/){
      return ($new,keep_going(@lines[1..$fi-1]),"$indent} ",keep_going(@lines[$fi..$#lines])) if (@lines[$fi..$#lines]);
      return ($new,keep_going(@lines[1..$fi-1]),"$indent} ");
    }
    return ($new,keep_going(@lines[1..$fi-1]),"$indent}\n",keep_going(@lines[$fi..$#lines])) if (@lines[$fi..$#lines]);
    return ($new,keep_going(@lines[1..$fi-1]),"$indent}\n");
  }

  ## multi-line elif
  if ($line =~ /(^\s*)elif (.*):\s*$/){
    my $indent = $1;
    my $condition = $2;
    $condition =~ s/([a-zA-Z_][a-zA-Z0-9_]*)/\$$1/g;
    my $new = "elsif ($condition) {\n";
    my $fi = $#lines + 1;
    foreach my $x (1..$#lines){
      if ($lines[$x] !~ /^$indent(\t|    )/){
        $fi = $x;
        last;
      }
    }
    if ($lines[$fi] and $lines[$fi] =~ /^${indent}el(if|se)/){
      return ($new,keep_going(@lines[1..$fi-1]),"$indent} ",keep_going(@lines[$fi..$#lines])) if (@lines[$fi..$#lines]);
      return ($new,keep_going(@lines[1..$fi-1]),"$indent} ");
    }
    return ($new,keep_going(@lines[1..$fi-1]),"$indent}\n",keep_going(@lines[$fi..$#lines])) if (@lines[$fi..$#lines]);
    return ($new,keep_going(@lines[1..$fi-1]),"$indent}\n");
  }

  ## multi-line else
  if ($line =~ /(^\s*)else:\s*$/){
    my $indent = $1;
    my $new = "else {\n";
    my $fi = $#lines + 1;
    foreach my $x (1..$#lines){
      if ($lines[$x] !~ /^$indent(\t|    )/){
        $fi = $x;
        last;
      }
    }
    return ($new,keep_going(@lines[1..$fi-1]),"$indent}\n",keep_going(@lines[$fi..$#lines])) if (@lines[$fi..$#lines]);
    return ($new,keep_going(@lines[1..$fi-1]),"$indent}\n");
  }

  ## break or continue or pass
  if ($line =~ /^\s*(break|continue|pass)\s*$/ ) {
    $line =~ s/break/last;/;
    $line =~ s/continue/next;/;
    $line =~ s/pass//;
    my $new = "$line\n";
    return ($new,keep_going(@lines[1..$#lines])) if (@lines[1..$#lines]);
    return $new;
  }


  ## for loop in numberic range
  if ($line =~ /^(\s*)for ([a-zA-Z_][a-zA-Z0-9_]*) in range\((.+),\s*(.+)\):/) {
    my $indent = $1;
    my $iter = $2;
    my $from = $3;
    $from =~ s/([a-zA-Z_][a-zA-Z0-9_]*)/\$$1/g;
    my $to = $4;
    $to =~ s/([a-zA-Z_][a-zA-Z0-9_]*)/\$$1/g;
    $to = "$to - 1";
    my $fi = $#lines + 1;
    foreach my $x (1..$#lines){
      if ($lines[$x] !~ /^$indent(\t|    )/){
        $fi = $x;
        last;
      }
    }
    my $new = "${indent}foreach \$$iter ($from\.\.$to) {\n";
    return ($new,keep_going(@lines[1..$fi-1]),"$indent}\n",keep_going(@lines[$fi..$#lines])) if (@lines[$fi..$#lines]);
    return ($new,keep_going(@lines[1..$fi-1]),"$indent}\n");
  }

  ## for loop in numberic range(1 argument)
  if ($line =~ /^(\s*)for ([a-zA-Z_][a-zA-Z0-9_]*) in range\((.+)\):/) {
    my $indent = $1;
    my $iter = $2;
    my $from = 0;
    my $to = $3;
    $to =~ s/([a-zA-Z_][a-zA-Z0-9_]*)/\$$1/g;
    $to = "$to - 1";
    my $fi = $#lines + 1;
    foreach my $x (1..$#lines){
      if ($lines[$x] !~ /^$indent(\t|    )/){
        $fi = $x;
        last;
      }
    }
    my $new = "${indent}foreach \$$iter ($from\.\.$to) {\n";
    return ($new,keep_going(@lines[1..$fi-1]),"$indent}\n",keep_going(@lines[$fi..$#lines])) if (@lines[$fi..$#lines]);
    return ($new,keep_going(@lines[1..$fi-1]),"$indent}\n");
  }

  ## for loop in list
  if ($line =~ /^(\s*)for ([a-zA-Z_][a-zA-Z0-9_]*) in (sys\.stdin|[a-zA-Z_][a-zA-Z0-9_]*):/) {
    my $indent = $1;
    my $iter = $2;
    my $list = $3;
    $list =~ s/sys\.stdin/<STDIN>/;
    $list =~ s/^([a-zA-Z_][a-zA-Z0-9_]*)$/\@$1/;
    my $fi = $#lines + 1;
    foreach my $x (1..$#lines){
      if ($lines[$x] !~ /^$indent(\t|    )/){
        $fi = $x;
        last;
      }
    }
    my $new = "${indent}foreach \$$iter ($list) {\n";
    return ($new,keep_going(@lines[1..$fi-1]),"$indent}\n",keep_going(@lines[$fi..$#lines])) if (@lines[$fi..$#lines]);
    return ($new,keep_going(@lines[1..$fi-1]),"$indent}\n");
  }

  ## append list
  if ($line =~ /^(\s*)([a-zA-Z_][a-zA-Z0-9_]*)\.append\(([a-zA-Z_][a-zA-Z0-9_]*)\)$/) {
    my $indent = $1;
    my $arr = $2;
    my $element = $3;
    my $new = "${indent}push \@$arr, \$$element;\n";
    return ($new,keep_going(@lines[1..$#lines])) if (@lines[1..$#lines]);
    return $new;
  }

  ## pop list
  if ($line =~ /^(\s*)([a-zA-Z_][a-zA-Z0-9_]*)\.pop\(.*\)$/) {
    my $indent = $1;
    my $arr = $2;
    my $new = "${indent}pop \@$arr;\n";
    return ($new,keep_going(@lines[1..$#lines])) if (@lines[1..$#lines]);
    return $new;
  }


  ## sys.stdout.write
  if ($line =~ /^(\s*)sys\.stdout\.write/) {
    $line =~ s/sys\.stdout\.write\(/print /;
    $line =~ s/\)\s*$/;/;
    my $new = "$line\n";
    return ($new,keep_going(@lines[1..$#lines])) if (@lines[1..$#lines]);
    return $new;
  }

  ## sys.stdout.readline
  if ($line =~ /^(\s*)sys\.stdout\.write/) {
    $line =~ s/sys\.stdout\.write\(/print /;
    $line =~ s/\)\s*$/;/;
    my $new = "$line\n";
    return ($new,keep_going(@lines[1..$#lines])) if (@lines[1..$#lines]);
    return $new;
  }

  ## declare list
  if ($line =~ /^(\s*)([a-zA-Z_][a-zA-Z0-9_]*)\s*=\s*\[(.*)\]\s*$/) {
    @lists = push_distinct(@lists, $2);
    $line =~ s/([a-zA-Z_][a-zA-Z0-9_]*)/\$$1/g;
    $line =~ s/^(\s*)\$/$1\@/;
    $line =~ s/\[/(/;
    $line =~ s/\]\s*$/)/g;
    my $new = "$line;\n";
    return ($new,keep_going(@lines[1..$#lines])) if (@lines[1..$#lines]);
    return $new;
  }

  ## Lines we can't translate
  my $new = "|$line|\n";
  return ($new,keep_going(@lines[1..$#lines])) if (@lines[1..$#lines]);
  return $new;
}

$file = shift @ARGV;                            ## main
open F, '<', $file;
@python = <F>;
@variables = ();
@lists = ();
@perl = keep_going(@python);
print @perl;
