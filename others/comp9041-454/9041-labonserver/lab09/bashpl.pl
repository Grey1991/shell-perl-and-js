#!/usr/bin/perl -w
while ($line=<>){
    if ($line=~ /#!\/.+/){
      $line="#!/usr/bin/perl -w\n";
    }
    if ($line=~ /^\s*([a-zA-Z_][a-zA-Z0-9_]*)\s*=\s*\d+/){
        $line=~ s/($1)/\$$1/;
        $line=~ s/\n/;\n/;
    }
    if ($line=~ /\bdo\b/){
      $line=~ s/do/{/;
    }
    if ($line=~ /\bdone\b/){
      $line=~ s/done/}/;
    }
    if ($line=~ /while\s*\(\(.+\)\)\s*/){
      $line=~ s/\(\(/\(/;
      $line=~ s/\)\)/\)/;
      $line=~ s/([a-zA-Z_][a-zA-Z0-9_]*)/\$$1/g;
      $line=~ s/\$while/while/;
    }
    if ($line=~ /^\s*[a-zA-Z_][a-zA-Z0-9_]*\s*=\s*\$[a-zA-Z_][a-zA-Z0-9_]*.*/){
      $line=~ s/\$//;
      $line=~ s/([a-zA-Z_][a-zA-Z0-9_]*)/\$$1/g;
      $line=~ s/\n/;\n/;
    }
    if ($line=~ /^\s*[a-zA-Z_][a-zA-Z0-9_]*\s*=\s*\$\(\(.+\)\)/){
      $line=~ s/\$\(\(//;
      $line=~ s/\)\)/;/;
      $line=~ s/([a-zA-Z_][a-zA-Z0-9_]*)/\$$1/g;
    }
    if ($line=~ /if\s*\(\(.+\)\)\s*/){
      $line=~ s/\(\(/\(/;
      $line=~ s/\)\)/\)/;
      $line=~ s/([a-zA-Z_][a-zA-Z0-9_]*)/\$$1/g;
      $line=~ s/\$if/if/;
    }
    if ($line=~ /\bthen\b/){
      $line=~ s/then/{/;
    }
    if ($line=~ /\belse\b/){
      $line=~ s/else/} else {/;
    }
    if ($line=~ /\bfi\b/){
      $line=~ s/fi/}/;
    }
    if ($line=~ /echo /){
      $line=~ s/echo /print "/;
      $line=~ s/\n/\\n";\n/;
    }

    print "$line";
}
